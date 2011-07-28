From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 11/11] vcs-svn,svn-fe: add an option to write svnrev
 notes
Date: Thu, 28 Jul 2011 12:27:29 +0200
Message-ID: <20110728102729.GC6991@elie>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-12-git-send-email-divanorama@gmail.com>
 <20110725213923.GC8708@elie.dc0b.debconf.org>
 <CA+gfSn9MGiBJ-vhj25wMa5Jwu0hWo0Uyv2wiYst09+M6VX1SQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 12:27:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmNoh-0003Ph-RD
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 12:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab1G1K1m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 06:27:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60466 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1G1K1l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 06:27:41 -0400
Received: by fxh19 with SMTP id 19so1135701fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZWo/tfzRsBCBjwH+K7eMnV7DKnwgwfY6p557kKbouq8=;
        b=omV70pZyS0Roxo5mApxCaMqAzNqqvQc9cZb43oWiIdSiBPVDlpKSjZrNbxE9VKKVqN
         MuGUITypzsKz6lPwaIztT7E308rOUVHFrHf1VwhqlRoRT7EtoDVwhtlGFoUA7vLHB0Q6
         RohFElM//UCPLl0ChnO/czZ+cCwCD0XPdLpdc=
Received: by 10.223.15.141 with SMTP id k13mr1146864faa.118.1311848860472;
        Thu, 28 Jul 2011 03:27:40 -0700 (PDT)
Received: from elie (adsl-165-140-99.teol.net [109.165.140.99])
        by mx.google.com with ESMTPS id 28sm391424fax.27.2011.07.28.03.27.38
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 03:27:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn9MGiBJ-vhj25wMa5Jwu0hWo0Uyv2wiYst09+M6VX1SQA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178054>

Dmitry Ivankov wrote:
> On Tue, Jul 26, 2011 at 3:39 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0--notes-ref=3Drefs/notes/svn-rev --note=3D=
'project foo, r%N'
>>
>> As a bonus, that would allow including more information using
>> different flag characters in the note in the future.
>
> Format string looks nice.

Yes, it sounds pleasant to work with to me.  Open questions:

 - how fine-grained should the notes commits be?  E.g., should they
   be written one at a time, in batches of 10, or something else?

 - is there a way to make some commits get no note at all?  Is this
   template-based approach the right way to go?  (I guess yes, it is.)

 - what if someone wants multiple notes refs (e.g., revision numbers
   and revprops in separate notes refs)?  Will this support that?  If
   not, is it extensible enough to sensibly support that in the
   future?

[...]
> One more consideration is that copy-from information most likely
> will be written by svn-fe (nothing else knows it anyway) to some
> notes, so we'll need some notes writing in svn-fe.

Yep, copyfrom info has to get downstream somehow.  Which means

   a. in log messages
   b. in notes
   c. in comments or "progress" lines in the stream, or
or d. in a second output stream, with file descriptor number specified
      by the caller.

I was leaning towards (a) or (c), but (b) certainly also seems
sensible.
