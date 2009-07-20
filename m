From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] Add git svn gc command
Date: Mon, 20 Jul 2009 10:15:28 +0200
Message-ID: <9b18b3110907200115p4c0c3b45nc6c7f31b34ceff0c@mail.gmail.com>
References: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com>
	 <20090720075929.GA5591@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Zeh <robert.a.zeh@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 20 10:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSo25-0007ma-9s
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 10:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbZGTIPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 04:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZGTIP3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 04:15:29 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:64747 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZGTIP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 04:15:29 -0400
Received: by gxk9 with SMTP id 9so3691015gxk.13
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I1W37j7VxLlFfT2/byw6AqNvs05QXB8p2EJ7F1W1oek=;
        b=FXsGcrvjHsh9T6iVB/Higk5jXndZdk8nzDk/gO6qwcLkxuo1UM5BmgAyBgRGA1q3RL
         7FJsTaDdmBIO5hTILYStJg6WmT4udjCAf15AZ2SrtEBab1DxIQ/d8p8+BCdiK0VSXT1g
         ib8M4FKM4fBbnHmZ6ghhR3lHBBy+q8DeougbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EpPnAUa59hP7sYbyKCuWBzv2W125MpStYnHnEJ0tAfoKsDRbt1cp85QpfwthdLBpNk
         4S0zva2DZTd5qTfgKLKKEac8doz2JSyONl2gksLDZCRMseAL9OGluxHJJjkkmOZ9C2aB
         fPxpTFEuSPXcivkBUUS9qSaspqBN0EwoVOy7Y=
Received: by 10.231.11.135 with SMTP id t7mr192270ibt.12.1248077728492; Mon, 
	20 Jul 2009 01:15:28 -0700 (PDT)
In-Reply-To: <20090720075929.GA5591@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123579>

2009/7/20 Eric Wong <normalperson@yhbt.net>:
> Robert Zeh <robert.a.zeh@gmail.com> wrote:
>> Add a git svn gc command that gzips all unhandled.log files, and rem=
oves
>> all index files under .git/svn.
>>
>> Signed-off-by: Robert Allan Zeh <robert.a.zeh@gmail.com>
>> ---
>> =A0Documentation/git-svn.txt | =A0 =A04 ++++
>> =A0git-svn.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 37 ++++++++++++++++=
+++++++++++++++++++++
>> =A0t/t9140-git-svn-gc.sh =A0 =A0 | =A0 45 ++++++++++++++++++++++++++=
++++++++++
>> +++++++++
>> =A03 files changed, 86 insertions(+), 0 deletions(-)
>> =A0create mode 100755 t/t9140-git-svn-gc.sh
>
> Hi Robert,
>
> Your mailer is mangling whitespace badly so the patch isn't applying
> at all. =A0Make sure indents are real tabs like the rest of the code.
>
> Some more comments below, but I think this will be a good addition
> to git svn.
>
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -35,11 +35,14 @@ push @Git::SVN::Ra::ISA, 'SVN::Ra';
>> =A0push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
>> =A0push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
>> =A0use Carp qw/croak/;
>> +use Compress::Zlib;
>
> I'd "require" Compress::Zlib lazilly so it's not loaded at startup.
> It's not a stock component of Perl and not needed for the majority of
> commands.

Actually, it has been a core component since 5.9.3

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
