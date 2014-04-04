From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 03/10] diffcore-pickaxe.c: Refactor pickaxe_fn signature
Date: Fri, 04 Apr 2014 13:09:05 +0200
Message-ID: <533E92D1.9020406@gmail.com>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu> <6822f9d947ffb589df25537e2c1e7c4ead7656b0.1395942768.git.davidad@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, l.s.r@web.de,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 13:09:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW1zw-0004Zt-01
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 13:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbaDDLJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 07:09:15 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:58618 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbaDDLJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 07:09:12 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so3275597wes.17
        for <git@vger.kernel.org>; Fri, 04 Apr 2014 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZYofjYe/A5cDro81SrY/6E1/m59AflzKZH/eznH4klI=;
        b=VIxIl/7FM1bV1ZEX0/VR1+AM7v1WRsQtxuLdmLtS7dgvzOemJ1YLfKC5tGYQvq4YOJ
         R4xO4xVrAhknpEBHPzj1rrn8W1gvuRCsadjZiZYPlwe3k4zZxj7STAtaL7zpAHMnhPpk
         oSnH1zweTdArbZJ1s0XReY8NFN8r9H90oQRmtLxhh5oPvEpBniCRQKNVhSa5M8Fu9U3Q
         KrdJ2SpwFH04QSYfKIoOd8xZGa5PzPatuWL7Kha7h5Whp71wZKEtnrbsrRXasuvFK4wA
         h/dqPem61cgDFgOBJyCR0bXHLFf4z7YQPLq+BIov7AOwiXR188B5YEz4TGbblrVUWrd5
         7++w==
X-Received: by 10.194.48.80 with SMTP id j16mr18976206wjn.44.1396609751291;
        Fri, 04 Apr 2014 04:09:11 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id z48sm18816240eel.27.2014.04.04.04.09.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 04:09:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <6822f9d947ffb589df25537e2c1e7c4ead7656b0.1395942768.git.davidad@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245758>

W dniu 2014-03-27 19:50, David A. Dalrymple (and Bhushan G. Lodha) pisze:
> From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>
>
> This function type previously accepted separate regex_t and kwset_t
> parameters, which conceptually go together. Here we create a struct to
> encapsulate them, in anticipation of adding a third field that
> pickaxe_fn's may require.
>
> This parallels the existing diffgrep_cb structure for passing possibly
> relevant values through to the callbacks invoked by xdi_diff_outf.

If it parallels existing diffgrep_cb structure, why not name this
equivalent in simular way, i.e. pickaxe_cb or pickaxe_options or
pickaxe_cb_opts instead of generic name fn_options?

> Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
> ---
>   diffcore-pickaxe.c | 50 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 0d36a3c..7e65095 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -8,17 +8,22 @@
>   #include "xdiff-interface.h"
>   #include "kwset.h"
>
> +struct fn_options {
> +	regex_t *regex;
> +	kwset_t kws;
> +};
