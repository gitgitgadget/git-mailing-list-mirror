From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 1 Apr 2010 15:06:47 -0700
Message-ID: <h2vd411cc4a1004011506p4d2db46bjafbe22f702b0f869@mail.gmail.com>
References: <o2xd411cc4a1004011329wcbe34a45he7f3d7ce5d4eae59@mail.gmail.com>
	 <7v39zeoo70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 00:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxSXP-0000zE-C0
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 00:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab0DAWGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 18:06:50 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56589 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab0DAWGs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 18:06:48 -0400
Received: by wwb17 with SMTP id 17so1101502wwb.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=riEZaGHFboS76EQgyVNYdV86DlkCrKy+Vdir6rHMbnw=;
        b=VZTQKu9tcRocfvCdMZMzMDG7ft2Skb87Lr7yz+k7YWBFrzpSx95fajN+++A/PYMXLY
         yZrU+wV92tLpapmhqP2x86Q3hvg63mw4afJvaa6iZwQTr9F+HeCPUB8X4U43IqgS6Ctg
         BwlSUXv1iRWxBhTUDr85LyqxMYUJtJ1MdTszk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CSGYcEzaZGLw6+CQt57Nsiij7sZYdkaBbno4KMIkyQr5RCilmylWej6p+PsQqgEvlR
         VB4LrZn3hGlbEVWo8lbsAgrEjyweX28UO7JrfvN3UXY+P9OfwjVX9UxqIhTIljDUhPTr
         XnK8aPrINR6Uh3Jqry3QesHoYTyx3TKGgAAHE=
Received: by 10.216.52.2 with HTTP; Thu, 1 Apr 2010 15:06:47 -0700 (PDT)
In-Reply-To: <7v39zeoo70.fsf@alter.siamese.dyndns.org>
Received: by 10.216.88.10 with SMTP id z10mr707180wee.108.1270159607655; Thu, 
	01 Apr 2010 15:06:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143755>

Hey,

On Thu, Apr 1, 2010 at 2:30 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> Also, earlier I said "sometimes OK", because I don't know if it alway=
s OK
> for us to get 401 and continue. =C2=A0If the end user got a 401 and t=
hen does
> not have a good username or password (e.g. he realizes that the URL h=
e
> accessed was incorrect), he used to see "you are not allowed to acces=
s
> this repository" with a clean failure, but now he would have to get o=
ut of
> "who are you?" interaction (and how would he do that?). =C2=A0Would t=
hat be a
> problem?

They did not get a clean failure, it looks like this:

--
$ git clone http://github.dev/defunkt/ambition.git
Initialized empty Git repository in /private/tmp/svn/ambition/.git/
error: The requested URL returned error: 401 while accessing
http://github.dev/defunkt/ambition.git/info/refs

fatal: HTTP request failed
--

"401 while accessing X, HTTP request failed" is not really a clean
failure.  Most people don't know what a 401 is.  With this patch, if
they get prompted for a user/pass on 401 and it still fails, they see
this:

--
$  ~/bin/git clone http://github.dev/defunkt/ambition.git
Initialized empty Git repository in /private/tmp/svn/ambition/.git/
Username:
Password:
fatal: Authentication failed
--

I think "Authentication failed" is a bit cleaner.  I'm sending another
patch with the comment format change and message update.

Scott
