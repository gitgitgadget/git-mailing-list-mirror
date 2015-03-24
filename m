From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git ignore help
Date: Tue, 24 Mar 2015 08:00:23 +0700
Message-ID: <CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com>
References: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz> <CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mdconf@seznam.cz, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:02:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaDE9-0001t4-2w
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 02:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbbCXBAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 21:00:55 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35981 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbCXBAz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 21:00:55 -0400
Received: by igbud6 with SMTP id ud6so58781934igb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 18:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zSUlgpE+KcTOzUlbPDQzi0Ze0eQI2VRUh65MsA3EG8Y=;
        b=lwbEnOFlf7lYTI2zgtRE7pyeSRKOaBCq0sI8xCv2fbQgVKgnSBDEAI2Pfo2xdtX9nf
         jKqmOLvAzoPMvtYW0yG3vTpHICgxLtuKE0Sz+xHaeaj6/zJl6US3T3FlbME0k63HRBO2
         R1ql4kf8IG7GZCOkNAUMJ9hS+Pz8Kcz8KaotP5fptKQ4jWI/LdOtr3XN9WzZ/iD4BQl4
         U/kbG1Cj2xP5PR1bck53+hJE5EEWKOp86iozfsxRg927uoaVRIcKKS/uh409TKi2VMzO
         rHTgKp4lgyYEvztU8WtRRCZ8niEtBLCFyT98mCWObaJ/d0vBL2BXgQFEl+22/CmyWKY5
         Wipg==
X-Received: by 10.50.118.97 with SMTP id kl1mr11395250igb.23.1427158854208;
 Mon, 23 Mar 2015 18:00:54 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 23 Mar 2015 18:00:23 -0700 (PDT)
In-Reply-To: <CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266170>

On Sun, Mar 22, 2015 at 10:33 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Fri, Mar 20, 2015 at 6:36 AM,  <mdconf@seznam.cz> wrote:
>> I am trying to setup my git ignore (resp. .git/info/exclude) so that=
 I exclude
>>  all directories and files except the content of directories that I
>> specifically include (incl. anything within them recursively).
>>
>> I set the .git/info/exclude with the following content:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D
>> # Exclude everything
>> /*
>> # Except the below that we include
>> !/db/data/load/base/bootstraponly
>> !/db/data/load/base/safetoload
>> !/db/ddl
>> !/labels
>> !/reports/usrint
>> !/scripts
>> !/src/cmdsrc/usrint
>> =3D=3D=3D=3D=3D=3D=3D=3D
>>
>> However it does not do what I anticipated. It indeed excludes everyt=
hing but
>> the include part does not work - it only works for !/labels and !/sc=
ripts
>> directories (i.e. the first level directories). All other are still =
ignored -
>> so when I create file /db/data/load/base/bootstraponly/somefile.txt =
git still
>> ignores it...
>>
>> Any idea what I am doing wrong?
>
> The fourth bullet point of the "Pattern Format" section of the
> gitignore man page has this to say, which explains the behavior you'r=
e
> seeing:
>
>     An optional prefix "!" which negates the pattern; any matching
>     file excluded by a previous pattern will become included again.
>     It is not possible to re-include a file if a parent directory of
>     that file is excluded. Git doesn=E2=80=99t list excluded director=
ies for
>     performance reasons, so any patterns on contained files have no
>     effect, no matter where they are defined.

This is true. To elaborate, if we have to recurse in excluded
directories so that we can include some back, then the reason for
excluding is already defeated as we may need to traverse the entire
directory structure. However in this particular case where we do know
in advance that only certain directories may have "re-include" rules,
e.g. "db", "reports" or "scripts", we could keep going for a while. I
think I attempted to do this in the past and failed (don't remember
exactly why). Maybe I'll try again some time in future.

Another option is, if the user is willing to accept performance
degradation (in many small repos, it does not matter anyway), then we
could keep digging in.
--=20
Duy
