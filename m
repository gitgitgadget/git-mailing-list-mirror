From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2015, #01; Mon, 5)
Date: Mon, 05 Oct 2015 22:35:50 -0700
Message-ID: <xmqqoagcwocp.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpv0x6op.fsf@gitster.mtv.corp.google.com>
	<561351FD.9020102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 07:36:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjKut-0000NT-KL
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 07:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbbJFFfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 01:35:55 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34231 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbJFFfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 01:35:54 -0400
Received: by padhy16 with SMTP id hy16so58950113pad.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 22:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Jw7sFuEPgQAoeq3uoSSVrq9ni0U1FHDHhB6pz+40zpM=;
        b=qtRJ6TysQHzyE5rO25kus1qE0Ys/gsyfoTzwk7ymObtbYIYz+wl75dBm6imXpeZfiM
         RuJqtFIk12y1eP92a5mR4EwtIA1Ye4S0rFllBUi1b113mDz/lJtQA/ysCC49UtshIxcA
         KpDUMHbZU7LUwyasAhLO+9antRr0teEWwSObs0o46ZIcALpf2R0ZdSK3wHqV1JjMhyeP
         Q90uI2yNYLg2w63uNJl9AsWIg+/pdE10jj0Pna8IU70/Z7uRHyVg+jIWL8et0WV4EYX1
         o/+G3Y77KRegIdks+n0eOYOBpnZXPiRdSSlLTIVXIcOaYxYHHBCyFNMRsuTMRviNU6VK
         xouw==
X-Received: by 10.68.98.99 with SMTP id eh3mr44567738pbb.126.1444109753539;
        Mon, 05 Oct 2015 22:35:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a14c:f96c:97d2:eee0])
        by smtp.gmail.com with ESMTPSA id be6sm31039251pad.5.2015.10.05.22.35.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 22:35:51 -0700 (PDT)
In-Reply-To: <561351FD.9020102@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 6 Oct 2015 06:45:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279119>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 06.10.15 00:59, Junio C Hamano wrote:
>> * gr/rebase-i-drop-warn (2015-10-02) 2 commits
>>  - rebase-i: loosen over-eager check_bad_cmd check
>>  - rebase-i: explicitly accept tab as separator in commands
>>=20
>>  "git rebase -i" had a minor regression recently, which stopped
>>  considering a line that begins with an indented '#' in its insn
>>  sheet not a comment, which is now fixed.
>>=20
>>  Will merge to 'next'.
> This is breaking using a non-gnu sed, which doesn't handle "\t"...

Thanks for catching this, and the other one in the stalled section,
before they hit 'next'.

> The solution is to replace "\t" with a literal TAB.

Obviously correct ;-)  Will squash in.

Thanks again.

>
>
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interacti=
ve.sh
> index 3da3ba3..3de0b1d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1232,7 +1232,7 @@ test_expect_success 'tabs and spaces are accept=
ed in the todolist' '
>  	write_script add-indent.sh <<-\EOF &&
>  	(
>  		# Turn single spaces into space/tab mix
> -		sed "1s/ /\t/g; 2s/ /  /g; 3s/ / \t/g" "$1"
> +		sed "1s/ /	/g; 2s/ /  /g; 3s/ / 	/g" "$1"
>  		printf "\n\t# comment\n #more\n\t # comment\n"
>  	) >$1.new
>  	mv "$1.new" "$1"
