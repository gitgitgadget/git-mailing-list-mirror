From: Michael Olson <mwolson@gnu.org>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to 
	stop git-svn
Date: Wed, 21 Apr 2010 14:17:13 -0700
Message-ID: <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com> 
	<1271880470.20208.47.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:17:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hIn-0000JW-Tv
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab0DUVRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 17:17:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37071 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab0DUVRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 17:17:35 -0400
Received: by vws18 with SMTP id 18so354794vws.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:17:35 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Wed, 21 Apr 2010 14:17:13 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
In-Reply-To: <1271880470.20208.47.camel@denix>
X-Google-Sender-Auth: baab65afbe6a5322
Received: by 10.220.107.137 with SMTP id b9mr6060006vcp.227.1271884653861; 
	Wed, 21 Apr 2010 14:17:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145455>

On Wed, Apr 21, 2010 at 1:07 PM, Sam Vilain <sam@vilain.net> wrote:
> On Tue, 2010-04-20 at 14:30 -0700, Michael Olson wrote:
>> Instead, fall back to assuming that the incoming merge is a bunch of
>> cherry-picks and ignore it.
>>
>> Signed-off-by: Michael W. Olson <mwolson@gnu.org>
>> ---
>> =C2=A0git-svn.perl | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 0e1feb3..1a53709 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -3110,7 +3110,7 @@ sub check_cherry_pick {
>> =C2=A0 =C2=A0 =C2=A0 my %commits =3D map { $_ =3D> 1 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _rev_list("--no-mer=
ges", $tip, "--not", $base);
>> =C2=A0 =C2=A0 =C2=A0 for my $range ( @ranges ) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 delete @commits{_rev_lis=
t($range)};
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval { delete @commits{_=
rev_list($range)} };
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 for my $commit (keys %commits) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_no_changes(=
$commit)) {
>
> If the _rev_list here fails, it means it was passed in a bad range.
> This means that the calling code somehow ends up with a commit ID
> which doesn't exist. =C2=A0It's normally better to detect errors when
> they happen, not deeper into other functions when they break things..=
=2E

Interestingly, I see people reporting the same problem in the thread
"git svn clone of subversion's own code failing".  So it's not just
related to patch 1/2 of this series.  At least that thread has a
public-facing repo so the problem should be easier to reproduce for a
real fix.

--=20
Michael Olson  |  http://mwolson.org/
