From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH v2] submodule: prevent warning in summary output
Date: Mon, 26 Aug 2013 20:26:51 +1200
Message-ID: <521B114B.2080709@gmail.com>
References: <1376958397-800967-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Aug 26 10:25:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDs7W-0007by-3l
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 10:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab3HZIZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 04:25:50 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39244 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab3HZIZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 04:25:49 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so3184251pdi.14
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 01:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=InzDPHIwgRSs55759li4guRfPduBt43DrAnpSRaEVpY=;
        b=c1QZiiqQIMqsz3FOjDXaMSlyPRnYK68tK0/djPmiMfHbXRbLL4xifBxAlX3rLgfo7e
         kb6wv/BrThGklfZQShKHnw9tGOEzKAyBHe2/wBb/6rx67YMz87mSSzTJOgkSeiskD17J
         F1wn1JgB2sFd1GCXqXDQbLKrCqMDOJErdhvz50VLEySJndffTSs35l1twTD05GkbVayj
         fposcLNgII2Nh30w8w/aGV15ACeg3dA5j4gjkuyfW7kooE1zNqftLj58111KDuD0Dmjd
         l6zTtmWkqt6TLp6SJwVWsB9beU8ydbIACf755OHTIW5z/a8PWK47XNf1QKmGox9Adh7Z
         owLg==
X-Received: by 10.66.243.196 with SMTP id xa4mr1506810pac.174.1377505547777;
        Mon, 26 Aug 2013 01:25:47 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id hx1sm16443512pbb.35.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 01:25:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <1376958397-800967-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232986>

Hi Brian,

Sorry for the delay.

On 20/08/13 12:26, brian m. carlson wrote:
> When git submodule summary is run and there is a deleted submodule, there is an
> warning from git rev-parse:
> 
>   fatal: Not a git repository: '.vim/pathogen/.git'
> 
> Silence this warning, since it is fully expected that a deleted submodule will
> not be a git repository.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> 
> I hesitated to add the test for $status because it will end up having no effect
> since we exclude that case later.  However, for correctness, I included it.
> 
>  git-submodule.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..eec3135 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1070,7 +1070,10 @@ cmd_summary() {
>  		missing_src=
>  		missing_dst=
>  
> +		test $status = D && missing_src=t

I tend to agree with you that this line is redundant. I'm not sure that
it's what Jens was looking for in v1.

> +
>  		test $mod_src = 160000 &&
> +		test -e "$name/.git" &&
>  		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
>  		missing_src=t
> 

This part looks good to me.
