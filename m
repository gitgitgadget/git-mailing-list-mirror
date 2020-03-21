Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD105C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D65A20724
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 17:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="xZ/R3WRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCUR2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:28:01 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]:45443 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCUR2B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 13:28:01 -0400
Received: by mail-qv1-f54.google.com with SMTP id h20so4881538qvr.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucmvNlVvgkCdupMo1tKN8yaWfnrclsJkBHK9Ul4eVSs=;
        b=xZ/R3WRx2fUZo8Mi/mdo88y50KVdyn+7hbs85za152i9+Gzq7MbwDm9Z3uoPA+z0Iu
         yX7mJw+fMSczUyGRtyzUs6syifMlykDjrw+ndqF3RUl1f85RohH/uZSfWxTCgSRXM0dT
         YncapHiQpPyuRXJmyOEZN7ODzV9BE6Y8eL9Z7XB1tZiKlJNT2At1JRmCAcp4X2/lcyLh
         r2eqAI/gAeaWNZgqkal80v5+r7hPrCdfEQPujiLFOxxu4T3JqVB5yvmfcooLX28igWs4
         DqUajRM2jcR+6UZr7N7CBWRk0W73DybhIkOnONOMEIu1PnJZ5/IkAIGKcS+vegzeRz/7
         M4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucmvNlVvgkCdupMo1tKN8yaWfnrclsJkBHK9Ul4eVSs=;
        b=o7rPrvaHtcqSrBEjej9KDy4dHwwU+VeWyLhgcw790kom2d+ie5viGkOqdOu2hadDTN
         HC75N0f4unuXWpKlT3BAOLqkGsIRoN+E+fDACfKd4doBhTaTB+hl7BlBEhybDvT4kkJh
         pi6qaFSJIlm1peuCWN4ZRzeffy2/JgH+stiVYkBU70R+NM9q7d3t2JgP5yddT5EowyJm
         Zvaf2xtsR+6Kan/VP0bTVAVK6I8/VKVY2Tthmopy0ikN0DEakXlzkVWUYIgkGk2jOMfU
         fKKbGkM4Syl2ffH45XZqP1jFu2DzTnliVkkiaTzcTTUjx4ULLzI6IUVS/psL+i36NfNI
         aopQ==
X-Gm-Message-State: ANhLgQ2SUTCq4jbvHC3NkzPmtBxI9IhzaFK/gr7r5np6nc1FnD9NewtU
        ex395gwZBFA1fCaByYoRq9y/4g==
X-Google-Smtp-Source: ADFU+vvHBOm0rR0d/qqGQ6MQm7PDeheK476WDgt/QzPRgxWd+QN8Tg6xnWmx8mociJVq5hvgqzO1zQ==
X-Received: by 2002:ad4:46e6:: with SMTP id h6mr13597154qvw.208.1584811679134;
        Sat, 21 Mar 2020 10:27:59 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id h143sm7229027qke.58.2020.03.21.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 10:27:58 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH] test-lib: allow short options to be stacked
Date:   Sat, 21 Mar 2020 14:27:52 -0300
Message-Id: <20200321172752.3268-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqsgi29um6.fsf@gitster.c.googlers.com>
References: <xmqqsgi29um6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 1:53 AM Junio C Hamano <gitster@pobox.com> wrote:
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > +parse_option () {
> > +	local opt="$@"
>
> I do not think there is any context in which var="$@" makes sense in
> shell script (var="$*" is understandable, though).  
>
> Did you mean opt=$1 here?

Right, it should be $1. Thanks.

> > +# Parse options while taking care to leave $@ intact, so we will still
> > +# have all the original command line options when executing the test
> > +# script again for '--tee' and '--verbose-log' below.
>
> The phrase "below" no longer makes much sense after moving lines
> around, does it?

Oh, I thought "below" referred to the later usage of $@ (when --tee or
--verbose-log are set). I.e. not the parsing section we moved up, but this
one:

elif test -n "$tee"
then
	...
	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;

Maybe change "below" for "later in the code"?

> > +store_arg_to=
> > +prev_opt=
> > +for opt
> > +do
> > +	if test -n "$store_arg_to"
> > +	then
> > +		eval $store_arg_to=\$opt
> > +		store_arg_to=
> > +		prev_opt=
> > +		continue
> > +	fi
> > +
> > +	case "$opt" in
> > +	--*)
> > +		parse_option "$opt" ;;
> > +	-?*)
> > +		# stacked short options must be fed separately to parse_option
>
> Are you calling concatenated short options, e.g. "-abc", as
> "stacked"?  It sounds like a very unusual phrasing, at least to me.

Yeah, I wasn't really sure about the naming for this. Thanks, "concatenated"
(or "bundled", as Peff suggested in another reply) does sound better.

