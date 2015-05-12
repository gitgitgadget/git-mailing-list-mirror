From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] completion: add a helper function to get config variables
Date: Tue, 12 May 2015 15:14:59 -0700
Message-ID: <xmqqa8x9e93w.fsf@gitster.dls.corp.google.com>
References: <1431262218-7304-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 13 00:15:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsISD-00039K-3K
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 00:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933807AbbELWPE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2015 18:15:04 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35439 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbbELWPB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 18:15:01 -0400
Received: by iebpz10 with SMTP id pz10so15443135ieb.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=ubVpQNr567KY5zU0/Gepa1vhd2lENNibq5jIMfyTBzk=;
        b=ess6aHMU1UADZ8w6+KUbLXz/IL0kb5qKTCRIMeACjxiDL/PmGs0OV72WriSFvEiuOD
         gritlEnNTwC/pMQch5UEXCadLG14xvXF3CzxgAV01+dmnhSUjQOzERFmXLHCsVnHfPLd
         KBrccnblZ3zfQd3FF/2xsXOslgm4YMNtF5nUfYeeOfKuaX982U0nLJkUc7+jj/gKIM87
         e4AB7WZ7c+vZ/GviRQHThlwhTdq2uUudJKPORknjjgQGsPm5yuMxjoQ+2jQ8WmUpA3jh
         75TuOEqlWK0olrAj1GxViaZ4UGuG96kdUhtDty+EdXvZFn0yVThO45ZzJ8H40rxgw4SE
         S1rA==
X-Received: by 10.50.30.9 with SMTP id o9mr6636021igh.23.1431468901310;
        Tue, 12 May 2015 15:15:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id r4sm2138615igw.12.2015.05.12.15.15.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 15:15:00 -0700 (PDT)
In-Reply-To: <1431262218-7304-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Sun, 10 May 2015 14:50:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268900>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> +	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "$sect=
ion\..*" 2>/dev/null); do
>  		case "$i" in
> -		pretty.*)
> -			i=3D"${i#pretty.}"
> +		$section.*)
> +			i=3D"${i#$section.}"

The case arm treats $section as a shell glob, --get-regexp treats it
as a regex fragment and then the shell expansion uses it as a
literal.

The current set of callers give simple single-token like pretty,
remote, etc. to it so this is safe, but you may want to give a
comment to the function to help future generation, perhaps?

Other than that, looks quite straight-forward.

Thanks.
