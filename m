From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [GIT GUI PATCH v2] git-gui: tolerate major version changes when
 comparing the git version
Date: Sun, 18 May 2014 12:31:49 +1200
Message-ID: <5377FF75.1070607@gmail.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>	<871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com>	<5369E58D.4030908@gmail.com> <53728D70.4020506@web.de>	<5373200D.7020108@web.de>	<xmqqlhu4jhcb.fsf@gitster.dls.corp.google.com>	<xmqqk39ohvyp.fsf@gitster.dls.corp.google.com> <87k39kbnmg.fsf@fox.patthoyts.tk> <5377BD31.8040004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	patthoyts@users.sourceforge.net, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 18 02:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlp1D-0000Wj-Se
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 02:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaERAb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 20:31:56 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:45639 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaERAbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 20:31:55 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so4249361pbc.1
        for <git@vger.kernel.org>; Sat, 17 May 2014 17:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VdEDUhYAkwFMpeWhSe7vSEG8hAUvVAoEU6L9b4jzBe8=;
        b=gBK+x44LU1VnBaimgORdBMdIzOe8Zo44rRw64dJyY6+J9Nls/PZ9z1Q/GPnNHhqNgB
         VMDMhLfq7PMSsfw3tCJ0fvY3ovMQe0tj5ztpvmazSQEIoE45hSA+P6gpy8V2G34hnV7P
         kPD0nb8v+D5imP0nYYvsGrsIWN3wI7h0ULr5CZo/VwoyILvfJf3ZErThMuCjkBVg6blN
         P89qqHIN2HRKXWGQwV66i281PNXbtnkT7Ec70F1jFZObB9N4fJLNu+O8hyoeT3PPZHQ3
         TiXfDaMN01MSszxsOpmD6KinmikJ/i9c4kndZuMHnW0a/q6Sc54ORGoQbWx+UIpsPFSr
         zdiQ==
X-Received: by 10.66.192.225 with SMTP id hj1mr32174858pac.142.1400373115233;
        Sat, 17 May 2014 17:31:55 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id pe3sm22047653pbc.23.2014.05.17.17.31.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 17 May 2014 17:31:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <5377BD31.8040004@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249493>

On 18/05/14 07:49, Jens Lehmann wrote:
> Since git 2.0.0 starting git gui in a submodule using a gitfile fails with
> the following error:
> 
>    No working directory ../../../<path>
> 
>    couldn't change working directory
>    to "../../../<path>": no such file or
>    directory
> 
> This is because "git rev-parse --show-toplevel" is only run when git gui
> sees a git version of at least 1.7.0 (which is the version in which the
> --show-toplevel option was introduced). But "package vsatisfies" returns
> false when the major version changes, which is not what we want here.
> 
> Fix that for both places where the git version is checked using vsatifies
> by appending a '-' to the version number. This tells vsatisfies that a
> change of the major version is not considered to be a problem, as long as
> the new major version is larger. This is done for both the place that
> caused the reported bug and another spot where the git version is tested
> for another feature.
> 
> Reported-by: Chris Packham <judge.packham@gmail.com>
> Reported-by: Yann Dirson <ydirson@free.fr>
> Helped-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> 
> Am 17.05.2014 14:23, schrieb Pat Thoyts:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>>
>>>>> Junio, I believe this issue needs to be fixed before 2.0 final. Otherwise
>>>>> git gui will not work inside submodules anymore due to the major version
>>>>> number change from 1 to 2. I'd like to hear Pat's opinion on this; even
>>>>> though I think my patch is less risky (as it doesn't change behavior for
>>>>> pre-2 versions), he might like Chris' proposal better.
>>>>
>>>> Thanks; I share the same feeling.
>>>
>>> So after checking git://repo.or.cz/git-gui.git/ and seeing that I am
>>> not missing any commit from there, I tentatively created a fork of
>>> it, applied your patch and merged it somewhere on 'pu' that is close
>>> to 'next'.  We may want to fast-track it to 2.0 without waiting for
>>> an Ack from Pat but let's give him one more day to respond.
>>>
>>
>> The analysis about the major version number being significant is
>> correct. By default vsatisfies assumes that a major version number
>> change means all lesser versions are incompatible. However, you can
>> prevent that assumption using an unlimited check by appending a - (minus
>> sign) to the version to yield an open ended range. Or by giving another
>> range. So the only change required is to append a minus.
>>
>>   package vsatisfies $::_git_version 1.7.0-
>>
>> will suffice.
>>
>>   package vsatisfies $::_git_version 1.7.0 2.0.0
>>
>> would work but would cause failures when we arrive at git 3.0
> 
> Thanks for the review! In this version I added the '-' to the version
> passed to vsatisfies and updated the commit message accordingly. I
> tested the result and it fixes the regression.
> 
> Junio, please replace my old version with this. In the first version
> I forgot to add a ">= 0" after the vcompare, which results in all
> versions that are /different/ than the one checked against pass the
> test. While that fixes the 2.0.0 regression, it will fail for git
> versions older than the version that is tested for. So my first
> attempt wasn't /that/ different from Chris' proposal ... :-/
> 
> 
>  git-gui/git-gui.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index cf2209b..6a8907e 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1283,7 +1283,7 @@ load_config 0
>  apply_config
> 
>  # v1.7.0 introduced --show-toplevel to return the canonical work-tree
> -if {[package vsatisfies $_git_version 1.7.0]} {
> +if {[package vsatisfies $_git_version 1.7.0-]} {
>  	if { [is_Cygwin] } {
>  		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
>  	} else {
> @@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
>  		close $fd
>  	}
> 
> -	if {[package vsatisfies $::_git_version 1.6.3]} {
> +	if {[package vsatisfies $::_git_version 1.6.3-]} {
>  		set ls_others [list --exclude-standard]
>  	} else {
>  		set ls_others [list --exclude-per-directory=.gitignore]
> 

Works for me.
