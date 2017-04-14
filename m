Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6E920960
	for <e@80x24.org>; Fri, 14 Apr 2017 02:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbdDNCmW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 22:42:22 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36405 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdDNCmU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 22:42:20 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so38237324pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 19:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Nu0PKbPOF/AN4a3WrRTAm19Jh4Be5GjJyMQQHepHTc=;
        b=FvkUFbY67G7JqESFk4lqaIRMMkrTz64PIwij1+v6ndYsvLKacK5rFBYncptnSl65N7
         jliBH8/hzlhmYFqp9XZLLPrEP4wbQtlxxc/D82ST0yFJZJ04TVEZIq50FTus06/HNe6x
         C17tp+KC+Id1ZXed9BOpM4l1jtvgMszs3Q5qP9kemFH5mopGnFRRy1QrWXGV1sWS5p0j
         6Y2bzdjUz7Y0f35+fyrgHtpY3FSChuKpo5DxCEC7vt62lLDVTNoyQYCEQ8aaoOsxpzkG
         hIAjCMeZyLRt+WoRzZCa1a/2uW7TX3k+lOD2dLXZ5NVHX86EMp1ofAu1x63abCVB20xX
         YAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Nu0PKbPOF/AN4a3WrRTAm19Jh4Be5GjJyMQQHepHTc=;
        b=i3ZfWVh0MMv2shpIzSKAk7yfdkNpFowyDuxM/TOEzVo4EK0qA8/sn4YSxq2+zyD43V
         FjICZP96q8Qm7Ik8UX7x02TdqpRrxSxN5jWBmH9cdw69rSyfRh9rRywnWOaX8smm9eu4
         vXtiBbdpfo3NK45AxTE+lMSoxhjnfOZRHJLg3oSEWzcH783BiSz7rDKQeIzeLwfIdUMm
         Xyf4IHGhMfdOP2cEXV1nkvgFN/FJZryU0IcSx37wMu0ygbKhNpviDJDxZw3ZzSmwSjNd
         8builv2B1ft+1lCHcpPpIYq0RypZF+JmLUSsfR2ECy1MSi+ICTIxPLDj1aHQLPoBjghp
         EptA==
X-Gm-Message-State: AN3rC/67p6BWo+6UBzk23qcm0j71Q5hy9aq4msPvWS640VXX6hIPHmxx
        hwqCCwKN0UmF7jRzB0WyeQ==
X-Received: by 10.98.33.28 with SMTP id h28mr4821833pfh.248.1492137724934;
        Thu, 13 Apr 2017 19:42:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id g5sm516018pgn.38.2017.04.13.19.42.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 19:42:03 -0700 (PDT)
Date:   Thu, 13 Apr 2017 19:42:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 7/6] run-command: block signals between fork and execve
Message-ID: <20170414024202.GA27281@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413211428.GA5961@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413211428.GA5961@whir>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Eric Wong wrote:
> @@ -277,6 +278,8 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
>  		error_errno("exec '%s': cd to '%s' failed",
>  			    cmd->argv[0], cmd->dir);
>  		break;
> +	case CHILD_ERR_SIGPROCMASK:
> +		error_errno("sigprocmask failed restoring signals");

missing a break statement here I'll add it in, in the re-roll.

>  	case CHILD_ERR_ENOENT:
>  		error_errno("cannot run %s", cmd->argv[0]);
>  		break;

-- 
Brandon Williams
