From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 09:32:44 +0200
Message-ID: <87a9nn31wj.fsf@gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com> <20130521224119.GF30969@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, felipe.contreras@gmail.com, gitster@pobox.com
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 22 09:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf3Xa-0000OP-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 09:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab3EVHct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 May 2013 03:32:49 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:39409 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab3EVHct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 May 2013 03:32:49 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so903876eek.7
        for <git@vger.kernel.org>; Wed, 22 May 2013 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=B1BGgOGabslXKgx0Bvk8yukfS5N0+TkkBY/rhlZCiPs=;
        b=WHSaYmEK6htwelaqQ1RhH7tEZjXrZHJE4p/s5wPSu50yfocz9gopI5iBbQdP47y7WL
         T6SvIBkaYXnKT0nEv+d0pGyA3xDW53cg8f3FossO1Pc5hoFT8x6fTP1lCP0iOhyfBRO7
         VdCTjZIRSz+aURhk40NNxMjTu4/S+87sb3SRQZUP2wrUZ5RY84/xraoLLqtHe8HBwHVx
         a1+VdbN5mA6Kje1Nrh4cXvLKIosAVoma4w38YGsnEzsm307kdqR/wbPo8KsKiKyE3sFe
         1eZxs+vd2VF8PUcIvG5DTZVdI0llaOShdibskk28O9Jiybmuo6yxGqIzRmoK3YPTJ0L2
         DEHA==
X-Received: by 10.15.34.206 with SMTP id e54mr6511074eev.24.1369207967970;
        Wed, 22 May 2013 00:32:47 -0700 (PDT)
Received: from localhost (nat5.unibz.it. [46.18.27.5])
        by mx.google.com with ESMTPSA id w43sm8211041eeg.14.2013.05.22.00.32.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 00:32:46 -0700 (PDT)
In-Reply-To: <20130521224119.GF30969@goldbirke>
User-Agent: Notmuch/0.15.2+87~gc75dff3 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225133>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Hi,
>
>
> On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote:
>> Currently the __git_ps1 git prompt gives the following error with a
>> repository converted by git-svn, when used with zsh:
>>
>> 	   __git_ps1_show_upstream:19: bad pattern: svn_remote[
>>
>> This was introduced by 6d158cba (bash completion: Support "divergenc=
e
>> from upstream" messages in __git_ps1), when the script was for bash
>> only.  Make it compatible with zsh.
>
> What is the actual cause of this problem/incompatibility and how/why =
do
> these changes fix it?
>
>> -			svn_remote[ $((${#svn_remote[@]} + 1)) ]=3D"$value"
>> +			svn_remote[$((${#svn_remote[@]} + 1))]=3D"$value"
>
> I mean, did zsh really complained because of the space after the '[' =
?!

Yes, removing the spaces after the '[' fixes the problem.  I'm not very
proficient in shell scripting, so I can't tell if there is another
cause.

>> @@ -146,8 +146,8 @@ __git_ps1_show_upstream ()
>>  	svn*)
>>  		# get the upstream from the "git-svn-id: ..." in a commit message
>>  		# (git-svn uses essentially the same procedure internally)
>> -		local svn_upstream=3D($(git log --first-parent -1 \
>> -					--grep=3D"^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null)=
)
>> +		set -a svn_upstream "$(git log --first-parent -1 \
>> +					--grep=3D"^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null)=
"
>>  		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
>>  			svn_upstream=3D${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
>
> If so, then what about this one?

You're right, this line gives an error too, the code just wasn't
following that path before.  I'll fix it in the re-roll.  Other than
those two I couldn't spot any other occurrence of this pattern.

> Best,
> G=C3=A1bor

Thanks,
Thomas
