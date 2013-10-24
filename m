From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFE: support change-id generation natively
Date: Thu, 24 Oct 2013 09:07:41 +0700
Message-ID: <CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
 <201310212029.01589.thomas@koch.ro> <1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
 <201310211249.49568.mfick@codeaurora.org> <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
 <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com> <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 04:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZALR-0007in-RS
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 04:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab3JXCIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Oct 2013 22:08:13 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:50614 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab3JXCIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 22:08:12 -0400
Received: by mail-qc0-f179.google.com with SMTP id k18so1008979qcv.38
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 19:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+lrwRJAmYIhy7aU+XTBgQHP36v52hGw2k8qdEv5sUAA=;
        b=mZlt5OIBvIEPajhQ/nRfUdiFb7fZspavvmOq3aNRdjbAKPUb6fPuMg2faT07sOgKtg
         axBdr95dWTkeBsvTYFgiUI6UdvZ8IzhiVUq+5thBETta7wzgQfeYDMwXPbqzWi8p9fHN
         XPWYwuFQMskodCB9CUPNyYmbNO2KHaj6tb20zM+ppBCzswSeoSEDQ+NufC/o4cX6JD1Z
         1w09pTDo6fAuVBsWFVd8vVNZmCGR91kzVpXrKm3pjmJwfbkIyV0yae3QV3mVQ+YgK6Sx
         M241BHlBD4QIydcV6NwjWBgUII4Hx4xrGRVxFaGWBs3vRbdNy9hGXwbki4Nkf9p+yDDk
         3siA==
X-Received: by 10.224.125.4 with SMTP id w4mr864392qar.75.1382580491350; Wed,
 23 Oct 2013 19:08:11 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 23 Oct 2013 19:07:41 -0700 (PDT)
In-Reply-To: <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236561>

On Wed, Oct 23, 2013 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Oct 23, 2013 at 2:50 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> It would be just the matter of updating commit_tree_extended() in
>>> commit.c to:
>>>
>>>  - detect the need to add a new Change-Id: trailer;
>>>
>>>  - call hash_sha1_file() on the commit object buffer (assuming that
>>>    a commit object that you can actually "git cat-file commit" usin=
g
>>>    the change Id does not have to exist anywhere for Gerrit to
>>>    work---otherwise you would need to call write_sha1_file()
>>>    instead) before adding Change-Id: trailer;
>>>
>>>  - add Change-Id: trailer to the buffer; and then finally
>>>
>>>  - let the existing write_sha1_file() to write it out.
>>
>> I'm not objecting special support for Gerrit, but if the change is
>> just commit_tree_extended() why don't we just ship the commit hook i=
n
>> a new "Gerrit" template?
>
> It is not clear to me how you envision to make it work.

I don't have the source code. But the commit-msg hook document [1]
describes roughly what you wrote below, except the tree part. And I
suppose the hook has been working fine so far. Reading back the
original post, James ruled out always-active hooks in general and
wanted the control per command line. Perhaps we should add
--no-hooks[=3D<name>,<name>] to "git commit"? Or maybe it's still
inconvenient and --change-id is best.

[1] http://gerrit-documentation.googlecode.com/svn/Documentation/2.0/cm=
d-hook-commit-msg.html

> Na=C3=AFvely thinking, an obvious place to do this kind of thing may =
be
> the "commit-msg" hook, where the hook reads what the user prepared,
> finds that there is no existing "Change-Id:" trailer, and decides to
> add one.
>
> But what value would it add on that line as the Id?
>
> It wants to use the name of the commit object that would result if
> it were to return without further editing the given message, but we
> do not give such a commit object name to the hook, so the hook needs
> to duplicate the logic to come up with one.  It may be doable (after
> all, builtin/commit.c is open source), but we do not give the hook
> the commit object header (i.e. it does not know what the tree,
> parent(s), author, committer lines would say, nor it does not know
> if we are going to add an encoding line), so the hook needs to guess
> what we will put there, too.
--=20
Duy
