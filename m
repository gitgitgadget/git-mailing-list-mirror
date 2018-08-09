Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5496F1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeHITbG (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 15:31:06 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:51708 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbeHITbG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 15:31:06 -0400
Received: by mail-wm0-f41.google.com with SMTP id y2-v6so925871wma.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6WiVZssB0+HjvW5dO4MSS+sqbhV4gWi0HyzVF1TGKWU=;
        b=F6GMFXnwiHSIVcPsfMnn6GaahAZEjpX1dSfby/etOc3SjpWU56wak1EYkpNR6U4RaP
         Qrpma6fuXXKikyEXdf3w3WmtGKpgxQElkVM5dopoL5LUQC/c7A3mI6n45Lm6Cs63dPm/
         yUio7QkoCUyOb1ckYjonYvTAGB42497rTfXwOJBVPoLaLs5pw+7xa6pvkG0Q8+JVL+aP
         iZ3fJPkBtTfEGlGKhY77cVBXGbJKL9g8t0AO2DVSvXLsn1O5lLkwIY08jgVkxq+w0eP5
         GRJFkqzLgk6NLHRp66RR3vSwWF6qUDRHuzpUmXNA+X/VmAZfg+meXe7HwVRgeIjQ3R7O
         WYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6WiVZssB0+HjvW5dO4MSS+sqbhV4gWi0HyzVF1TGKWU=;
        b=Hz5e76YIo+qNxIIjknJx8Lg1gNZGywzZcvqrQZr6BMuvcFwa9pMKQ+YyDTfABj34s9
         /vkFy5z8kA4jT3tVMgsUgqjdutJTWDmrgQ5EPncwePcy/LX7dtuVmnSir87TWuujdURL
         ZXu4RHHBMOkH94GRy2BgoTaOZmhToT6FkrlvOfSnxX44TXW5yFOFy08XCanz5e9IIbZu
         z5YZukA/EJpQGWdNvD9jrEE48mov5NetOaznPHG+HeWXd5Qre5aLlMauAK7RS7yaXv2s
         pxlfGoRx/5m94RZgpUbZT3dbTip6QjGA+SNAmG57PZeYn6dzoOsvyTPULAb3AlM1EwLa
         Mk6w==
X-Gm-Message-State: AOUpUlHfS7nSEnXHVUd9EATvPOsT8PjTKa5z4mLh7lmFh0GJohyft6s9
        4EseBQNioJV+OLpTMjajbBY=
X-Google-Smtp-Source: AA+uWPx/noetQO9xTql+yac+5oLKl+4aqCfuWJy9Se3wBCu1e6SzA+ZAZVWgl7w9OgwNV1/BmIyKBQ==
X-Received: by 2002:a1c:b213:: with SMTP id b19-v6mr2076446wmf.141.1533834317740;
        Thu, 09 Aug 2018 10:05:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2-v6sm6475582wrn.83.2018.08.09.10.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 10:05:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/2] repack: repack promisor objects if -a or -A is set
References: <cover.1533672584.git.jonathantanmy@google.com>
        <cover.1533767314.git.jonathantanmy@google.com>
        <3dab08e467c23f2c0785e34c3a8703d809b6479a.1533767314.git.jonathantanmy@google.com>
Date:   Thu, 09 Aug 2018 10:05:16 -0700
In-Reply-To: <3dab08e467c23f2c0785e34c3a8703d809b6479a.1533767314.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 8 Aug 2018 15:34:06 -0700")
Message-ID: <xmqqftzncvxv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +/*
> + * Write oid to the given struct child_process's stdin, starting it first if
> + * necessary.
> + */
> +static int write_oid(const struct object_id *oid, struct packed_git *pack,
> +		     uint32_t pos, void *data)
> +{
> +	struct child_process *cmd = data;
> +
> +	if (cmd->in == -1) {
> +		if (start_command(cmd))
> +			die("Could not start pack-objects to repack promisor objects");
> +	}
> +
> +	xwrite(cmd->in, oid_to_hex(oid), GIT_SHA1_HEXSZ);
> +	xwrite(cmd->in, "\n", 1);
> +	return 0;
> +}
> +
> +static void repack_promisor_objects(const struct pack_objects_args *args,
> +				    struct string_list *names)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	FILE *out;
> +	struct strbuf line = STRBUF_INIT;
> +
> +	prepare_pack_objects(&cmd, args);
> +	cmd.in = -1;
> +
> +	/*
> +	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
> +	 * hints may result in suboptimal deltas in the resulting pack. See if
> +	 * the OIDs can be sent with fake paths such that pack-objects can use a
> +	 * {type -> existing pack order} ordering when computing deltas instead
> +	 * of a {type -> size} ordering, which may produce better deltas.
> +	 */
> +	for_each_packed_object(write_oid, &cmd,
> +			       FOR_EACH_OBJECT_PROMISOR_ONLY);
> +
> +	if (cmd.in == -1)
> +		/* No packed objects; cmd was never started */
> +		return;
> +	close(cmd.in);
> +
> +	out = xfdopen(cmd.out, "r");

Hmm, it is clever to auto-start the pack-objects (and notice there
wasn't anything needing to pack).  Two things that are worth noting
are:

 - The code takes advantage of the fact that cmd.in being left as -1
   is a sign that start_command() was never called (well, it could
   be that it was called but failed to open pipe---but then we would
   have died inside write_oid(), so we can ignore taht case).  This
   is not relying on its implementation detail---cmd.in would be
   replaced by a real fd to the pipe if start_command() was called.

 - We know that pack-objects reads all its standard input through to
   the EOF before emitting a single byte to its standard output, and
   that is why we can use bidi pipe and not worry about deadlocking
   caused by not reading from cmd.out at all (before closing cmd.in,
   that is).

So I kind of like the cleverness of the design of this code.

> +	while (strbuf_getline_lf(&line, out) != EOF) {
> +		char *promisor_name;
> +		int fd;
> +		if (line.len != 40)
> +			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
> +		string_list_append(names, line.buf);
> +
> +		/*
> +		 * pack-objects creates the .pack and .idx files, but not the
> +		 * .promisor file. Create the .promisor file, which is empty.
> +		 */
> +		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
> +					  line.buf);
> +		fd = open(promisor_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
> +		if (fd < 0)
> +			die_errno("unable to create '%s'", promisor_name);
> +		close(fd);
> +		free(promisor_name);

For now, as we do not know what is the appropriate thing to leave in
the file, empty is fine, but perhaps in the future we may want to
carry forward the info from the existing .promisor file?  What does
it initially contain?  Transport invoked with from_promisor bit
seems to call index-pack with "--promisor" option with no argument,
so this is probably in line with that.  Do we in the future need to
teach "--promisor" option to pack-objects we invoke here, which will
be passed to the index-pack it internally performs, so that we do
not have to do this by hand here?

In any case, don't we need to update the doc for the "--promisor"
option of "index-pack"?  The same comment for the new options added
in the same topic, e.g. "--from-promisor" and "--no-dependents"
options added to "fetch-pack".  It seems that the topic that ended
at 0c16cd499d was done rather hastily and under-documented?

> @@ -440,6 +513,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	/* End of pack replacement. */
>  
> +	reprepare_packed_git(the_repository);
> +

I do not think this call hurts, but why does this become suddenly
necessary with _this_ patch?  Is it an unrelated bugfix?

>  	if (delete_redundant) {
>  		int opts = 0;
>  		string_list_sort(&names);

Thanks.
