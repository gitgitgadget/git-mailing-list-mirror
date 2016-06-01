From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 12/13] dir_iterator: new API for iterating over a
 directory tree
Date: Tue, 31 May 2016 20:12:34 -0400
Organization: Twitter
Message-ID: <1464739954.3988.6.camel@twopensource.com>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
	 <e99655e5d919852479d223caec42e5bb294b4a2c.1464537050.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 02:12:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7tm6-0008KI-7d
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 02:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbcFAAMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 20:12:38 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36334 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbcFAAMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 20:12:37 -0400
Received: by mail-qk0-f170.google.com with SMTP id i187so2578755qkd.3
        for <git@vger.kernel.org>; Tue, 31 May 2016 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=GKgGVQkpT/RcJzPCQ9Dj8MNy7496sl2qO/eEKhWxPR4=;
        b=OcHOM8bX3MHd5JVlbxS2hAU4vKnK97oiuyiuE+/VAzzdzn1FVHUNrSL0aDG75fB1Ry
         44qEMqNgB9Uj/CuUrho+d9qkxmvm6AOhLBTMGtDHJ386qvKaW4HLLJHjWMQNN5/ycwg7
         Kyw72HBdOUznZI5D/AaDfUYN+kKQlWUYFp+wSNMvn6kZa54meKLE986GcgTHV+s5K3Ca
         sfWBwsY6NJMAEUW/DJw3RuzPeKLO52Q5RE2a92l2Ep1Nq7DCNm7HuMMNbmbHJs/E8rxw
         HnG0vmHk4/vPi2HRm2BEblx3AqUnv6a4cpdUZd7Jh+s+qkUu15Ij9VFig3+zGU9DajeQ
         gcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=GKgGVQkpT/RcJzPCQ9Dj8MNy7496sl2qO/eEKhWxPR4=;
        b=PDMLmRKtdt9Bj4PsYeO5x+5Ijz6Z3SZForh0qj3RYR9hx4phwWmY4hJrZbALOvuaLw
         VSUFLu70X2EbRPsu8mfMaZD7WcUClVBMTzalnzq0umYXvhaW93ZzIY+qQAQ3FiPy0Mlw
         JnQETajbOBaRo3AGkrTLP9exE8hyQdSnaPG/czfGiaMhNQZNb4/yaaClNe0f5InkaUai
         USG/4CUpygUsgmsed0NiaXEOxvA4CdwEuscCXJmQ5oQW30U6DmxAKtLm3F5PaFqxxumJ
         kMDxQP291cYQWP2ay8imT6xtivPTnKRAzun5MZg6PQY2tHivhsltEXzcifH+MYylhP2t
         eF3A==
X-Gm-Message-State: ALyK8tKEneqh3BfvkGYeXGIEe+UsJSb4WlXZIu4xnRk/IoFZNqwoFGgprWbYj3g+v4KAGA==
X-Received: by 10.55.20.208 with SMTP id 77mr29021945qku.124.1464739956244;
        Tue, 31 May 2016 17:12:36 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id d2sm7664667qtc.42.2016.05.31.17.12.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2016 17:12:35 -0700 (PDT)
In-Reply-To: <e99655e5d919852479d223caec42e5bb294b4a2c.1464537050.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296043>

On Mon, 2016-05-30 at 09:55 +0200, Michael Haggerty wrote:
> +struct dir_iterator_level {
> +	int initialized;
> +
> +	DIR *dir;
> +
> +	/*
> +	 * The length of the directory part of refname at this level


"refname"? Isn't this was for directories?

> +			if (lstat(iter->base.path.buf, &iter
->base.st) < 0)
> +				continue; /* silently skip */

Should we warn on non-ENOENT errors here?

> +/*
> + * End the iteration before it has been exhausted. Free the
> reference

s/reference/directory/
