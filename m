From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/3] Revert "git-svn: always initialize with 
	core.autocrlf=false"
Date: Thu, 4 Mar 2010 11:24:02 +0100
Message-ID: <40aa078e1003040224v57bbea92w83a01f95390f5f1b@mail.gmail.com>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
	 <1267647023-2604-3-git-send-email-kusmabite@gmail.com>
	 <40aa078e1003031216l5d164654ta8ff7ea6c8cf2162@mail.gmail.com>
	 <20100304095350.GB12885@dcvr.yhbt.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, dpotapov@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 04 11:24:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn8E2-0002My-Nn
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 11:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab0CDKYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 05:24:10 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55254 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab0CDKYG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 05:24:06 -0500
Received: by wwa36 with SMTP id 36so1330766wwa.19
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 02:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4dp95mBhjbZK9BCa/6DOu5icQ7gglEvYw+6T7QC/c/U=;
        b=M70/+8yCCIzwq3zaIxBTq71tAupc7uPkJxhMis0Nzjn+eR66eqHUIb6XDw1xmDZSV3
         OtBwmTE0qlQeetbEsqSuFNjm1vcy8Ek/PwLhiCRHnqQvRehFIzdfZFRcgao4mMT8TOOc
         8uCOlHCjJi162ihgS/uL+hQctvMWyZkT7YSn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=KEpRFDXvPlMd7iMm3WI1qaYaqsfRUQDQXvNSr4sHespMImDppX2cuEe6nxvOx7SkaR
         FQVwz18vyuQqLfri12E7Jpykp5WV8EhCw49xvE5WQpcmPPGzU6sNHRhK7vx4ntDfKST7
         3l4qrPGHPSZ7hQTQF9G6KAI9P3KJgUxEwlLdY=
Received: by 10.216.86.139 with SMTP id w11mr81649wee.10.1267698242949; Thu, 
	04 Mar 2010 02:24:02 -0800 (PST)
In-Reply-To: <20100304095350.GB12885@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141520>

On Thu, Mar 4, 2010 at 10:53 AM, Eric Wong <normalperson@yhbt.net> wrot=
e:
> Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> On Wed, Mar 3, 2010 at 9:10 PM, Erik Faye-Lund <kusmabite@googlemail=
=2Ecom> wrote:
>> > git-svn dcommit uses diff-tree (which does not apply CRLF conversi=
on) to
>> > generate SVN commits, so there never were any CRLF conversion issu=
es when
>> > commiting in the first place.
>>
>> Uhm, this comment is slightly wrong. diff-tree is used to find out i=
f
>> there's a change in a file at all. cat_blob(), which in turn uses "g=
it
>> cat-file", is used to get the file contents.
>>
>> Sorry for the noise.
>
> Hi Erik,
>
> Yes, diff-tree is only used to find changed paths, not the actual
> content changes. =A0git svn always uses entire blobs from cat-file.
>
> So cat-file won't do CRLF conversions at all, meaning this change is
> safe for previously created repos, correct?

Correct.

But existing git-svn clones (that was cloned after d3c9634 was
introduced) will still have autocrlf-conversions disabled anyway
(because d3c9634 disabled it), so people shouldn't see any difference
before either re-cloning or manually enabling core.autocrlf in the
repo. I don't think there's any way to automatically remove the config
option that d3c9634 set up without potentially stepping on the user's
toes. And I have a gut-feeling that it would be wrong thing to do
anyway.

--=20
Erik "kusma" Faye-Lund
