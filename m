From: Nguy Thomas <thomasxnguy@gmail.com>
Subject: Re: [PATCHv3 1/2] Warnings before rebasing -i published history
Date: Tue, 12 Jun 2012 09:45:08 +0200
Message-ID: <4FD6F384.6050800@gmail.com>
References: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339451781-29324-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 09:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeLnF-0006Cb-OF
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 09:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094Ab2FLHpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 03:45:16 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45582 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab2FLHpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 03:45:14 -0400
Received: by eeit10 with SMTP id t10so2087855eei.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uMEnAvtZ20471WhTDQqknd1L9L/1aWUAOl+qMRRIfcM=;
        b=topm+gSixIjhM2bBr06TwUTZG4oPBt4MnS9to4ik8cEOcng+E2BAkwOiJbfO4wC2fT
         0IUgIRqR0Csa2DU0oXjI7FbaniFkeH7b/2+cCYrL2zO08sVj5Y2gTvgVVFwPvXWDmbm8
         vIhYLxYRdytCJ9HE7IgYHfnxVG04YQoSCs2cYUpodJv/nf9mUM2SCImHB+qwJB0UoIzr
         uaMbBY3J+4jC0g8BPWlTcnHDSvV8833Dr8vDDeiKoecQ0k4yqJUeGmeHKYoeaLHmVVAO
         ZyFXKfBWlNPlnIMKt952KkLhyf4tnR9tMwCdxQ/Ycy9XNkRakPFEaqrFDWJERJ0Zf55L
         pI+Q==
Received: by 10.14.101.73 with SMTP id a49mr915236eeg.34.1339487113113;
        Tue, 12 Jun 2012 00:45:13 -0700 (PDT)
Received: from [130.190.28.220] (wifi-028220.grenet.fr. [130.190.28.220])
        by mx.google.com with ESMTPS id z5sm61153674eem.3.2012.06.12.00.45.11
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 00:45:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <1339451781-29324-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199768>

Le 11/06/2012 23:56, Lucien Kong a =E9crit :
> +# Add the name of the branches after each pick, fixup or squash comm=
it that
> +# is an ancestor of a remote-tracking branch.
> +add_remoterefs () {
> +	to_print=3D
> +	branches_name=3D
> +	while read -r command sha1 message
> +	do
> +		git branch -r --contains "$sha1">"$1.branch"
> +		if test -s "$1.branch"
> +		then
> +			while read -r branch
> +			do
> +				branches_name=3D"$branches_name $branch"
> +			done<"$1.branch"
> +		fi
> +
> +		if test "$to_print" !=3D "$branches_name"
> +		then
> +			if test -n "$to_print"
> +			then
> +				printf '%s\n' "# Commits above this line appear in:$to_print"
> +			fi
> +			to_print=3D$branches_name
> +		fi
> +		branches_name=3D
> +		printf '%s\n' "$command $sha1 $message"
> +	done>"$1.published"<"$1"
> +	cat "$1.published">"$1"
> +	rm -f "$1.published" "$1.branch"
> +}
>
Hum, this function doesn't consider the last commit.
It will be fixed.
