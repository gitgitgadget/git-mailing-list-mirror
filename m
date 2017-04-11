Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340B620970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdDKR1N (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:27:13 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33780 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdDKR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:27:12 -0400
Received: by mail-pf0-f169.google.com with SMTP id s16so1667906pfs.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwyH52KtlfCNgJZCdSgVUq49pxWfR9SsrRMt4ZGD0Qw=;
        b=EO8+t/FAHHNqLd9xVc/CUAKr7nxiF7hprONh/eUDGF4kE84G2oVb7M41CWA9Hzbcu6
         egaAbb3l5IKf+rIL9f/FKCbZEApRsOtt0dhSmUs2Uf3JLCJKDuRrQTLccfRm1Y38eRih
         xbVBRbMEkEDkMNZFpV5qoZUc73TbRqRQL+5u9iz6bUZQ2QGA0aw5fJNXjZWrXBb3qAlX
         ZRcMY3UgeFxZo97d9DcfHRyNaj8OO4Q/6SJS6IgcEzsHgvD0yuEtxIcGCLzFpeiVKw94
         Kurf2f+XqSzed7THEtPdNg26bqUhVYUCZnIFINIB2ZfMz82HZtngKaE5ouS/95PYO/nc
         wmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwyH52KtlfCNgJZCdSgVUq49pxWfR9SsrRMt4ZGD0Qw=;
        b=KuwfrKkQW/Dhz3qtAzl9aKEqwD2DseL9rYwCwxjdyeuvmWd/TSLCZ6zrR6DSWsviGi
         AuHov6hI3HlBeb7AtJaKLsRQSFl5F11Hc+I3NIcqUbFtYUsQu9n+xvv7Ip7FDCPw402l
         K+stx2ySt1hnBIVmmj4DDLniCkTWtfecwyr3rd7wvkrji6H1RUKmt6Tc/ARrVjDy6S2Y
         kSOuKx9CgKZ9tzi5uP4nHCSXvVhGnQY6YfawyEjlr8sNf7uJ46Fs1WSkhC78Br8VKE9c
         tvTs0nUhD8UCYQMNam/n61XUVmnnPQy+JG9YRj6kS9XepQmuJODoryxjfFeoa6wRfA+w
         Xb+g==
X-Gm-Message-State: AN3rC/5CZ1z/zpMtWYC366cTFwJQI5hBsFFWEZ+br2cxc+cgrKoo9kVrfqCigRC5PcRV8lna
X-Received: by 10.99.64.69 with SMTP id n66mr17918682pga.197.1491931631225;
        Tue, 11 Apr 2017 10:27:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9591:6d62:26a:6d59])
        by smtp.gmail.com with ESMTPSA id y65sm31787926pfd.82.2017.04.11.10.27.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:27:10 -0700 (PDT)
Date:   Tue, 11 Apr 2017 10:27:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] run-command: prepare child environment before forking
Message-ID: <20170411172709.GE36152@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-5-bmwill@google.com>
 <20170411005816.GK8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411005816.GK8741@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/10, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > In order to avoid allocation between 'fork()' and 'exec()' prepare the
> > environment to be used in the child process prior to forking.
> 
> If using something like posix_spawn(), this would be needed anyway, so
> I'll review it.
> 
> [...]
> > +++ b/run-command.c
> [...]
> > +static char **prep_childenv(const char *const *deltaenv)
> > +{
> > +	char **childenv;
> > +	int childenv_nr = 0, childenv_alloc = 0;
> > +	int i;
> > +
> > +	for (i = 0; environ[i]; i++)
> > +		childenv_nr++;
> > +	for (i = 0; deltaenv && deltaenv[i]; i++)
> > +		childenv_alloc++;
> > +	/* Add one for the NULL termination */
> > +	childenv_alloc += childenv_nr + 1;
> > +
> > +	childenv = xcalloc(childenv_alloc, sizeof(char *));
> > +	memcpy(childenv, environ, childenv_nr * sizeof(char *));
> > +
> > +	/* merge in deltaenv */
> > +	for (i = 0; deltaenv && deltaenv[i]; i++)
> > +		childenv_nr = do_putenv(childenv, childenv_nr, deltaenv[i]);
> > +
> > +	return childenv;
> > +}
> 
> This potentially copies around most of 'environ' several times as it
> adjusts for each deltaenv item. Can it be simplified? E.g.

The only time it copies anything is that first memcpy which makes a
duplicate of the environ, and then when an item is being removed in
do_putenv it will move the back of the array to fill in for the entry
being removed.

> 
> 	struct argv_array result = ARGV_ARRAY_INIT;
> 	struct string_list mods = STRING_LIST_INIT_DUP;
> 	struct strbuf key = STRBUF_INIT;
> 	const char **p;
> 
> 	for (p = cmd_env; *p; p++) {
> 		const char *equals = strchr(*p, '=');
> 		if (equals) {
> 			strbuf_reset(&key);
> 			strbuf_add(&key, *p, equals - *p);
> 			string_list_append(&mods, key.buf)->util = *p;
> 		} else {
> 			string_list_append(&mods, *p);
> 		}
> 	}
> 	string_list_sort(&mods);
> 
> 	for (p = environ; *p; p++) {
> 		struct string_list_item *item;
> 		const char *equals = strchr(*p, '=');
> 		if (!equals)
> 			continue;
> 		strbuf_reset(&key);
> 		strbuf_add(&key, *p, equals - *p);
> 		item = string_list_lookup(&mods, key.buf);
> 
> 		if (!item) /* no change */
> 			argv_array_push(&result, *p);
> 		else if (!item->util) /* unsetenv */
> 			; /* skip */
> 		else /* setenv */
> 			argv_array_push(&result, item->util);
> 	}
> 
> 	strbuf_release(&key);
> 	string_list_clear(&mods);
> 	return argv_array_detach(&result);

This is probably still incomplete as I don't see how this accounts for
entries in 'cmd_env' which are being added to the environment and not
just replacing existing ones.

-- 
Brandon Williams
