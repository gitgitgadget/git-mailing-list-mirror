Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A11820D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 02:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdFPCjd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 22:39:33 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36045 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbdFPCjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 22:39:32 -0400
Received: by mail-io0-f196.google.com with SMTP id i93so3345246iod.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rpklmBwMC6tk5mgyCPi82QSDqgiBCWBK2dGf/CBzccs=;
        b=OfSSBPotCyQYHBCbJ41tOGHWd6wvontGMLwV4NAUBAm1wMawy9URY5n/hCPODTmU11
         nKvpwzu8bx0F1Q4JeSEWX/W7ZV9EbaP3ggqtaDMZiav3fQLqh7GBp51RkngVloCcJa0o
         1hzVWV5qPwvKZugZ3aHXe23L0i5ZQlWkIHnFgNY1v3WNi/dAQM6J0s4etFiko/E5jKVz
         U8mWJkkxXNQeKZcJS0/AlXTPyZeMqi7oNT2xRIxaNuk22SfI80TWEEkTHPMwhHmHBusH
         moN1JPiDOnKh3IP+Sdke9J1ZBJwMEAOB86DiqS9ZnQSKB4D27FfjlP6CR+Dv4wMd4Btz
         HenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpklmBwMC6tk5mgyCPi82QSDqgiBCWBK2dGf/CBzccs=;
        b=cSkbBbwx+6xqZe4Y/u0EAFN8hHOHoEzE7WY0Ojs19pfQdtGZUac1s77XhlHzfEg4qX
         VSwhy+CnhSJgDl4BtXO2AwYeGGaAQGUjY5vjPJ0dU5RYSuHVi7sORWZ1t0Y2GGJNzJFi
         62uR7qPOHjfujM0hcOsU/xKezaCUm0YwcYMkl4xP8mDVdXw/Mx1eDvWAxq//bKHdCywX
         jESWRURmSoYPrlM5xphFOo/BZE01CxH7qxj97RUfZ38Wj/qjBfIhuwTSgC1w7ORguYR/
         RIwEiR98oix0Zah1FSN2wkfW5Y3FFM3/vZWzjLcy1/KRF2pPepou7ndMHEODBBOqKqgB
         9WCw==
X-Gm-Message-State: AKS2vOwrygG7WkD9wjAi1Q0XAkjowWur4Sv+bhVoaUP5tkfnbHrJN524
        9LH+LCI0g/yUPg==
X-Received: by 10.107.169.157 with SMTP id f29mr8762466ioj.61.1497580771544;
        Thu, 15 Jun 2017 19:39:31 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 131sm1025448itl.11.2017.06.15.19.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 19:39:30 -0700 (PDT)
Subject: Re: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
 <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de>
From:   Liam Beguin <liambeguin@gmail.com>
Message-ID: <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com>
Date:   Thu, 15 Jun 2017 22:39:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

On 14/06/17 09:08 AM, Johannes Schindelin wrote:
> diff --git a/sequencer.c b/sequencer.c
> index a697906d463..a0e020dab09 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2640,3 +2640,110 @@ int check_todo_list(void)
>  
>  	return res;
>  }
> +
> +/* skip picking commits whose parents are unchanged */
> +int skip_unnecessary_picks(void)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct strbuf buf = STRBUF_INIT;
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
> +	int fd, i;
> +
> +	if (!read_oneliner(&buf, rebase_path_onto(), 0))
> +		return error(_("could not read 'onto'"));
> +	if (get_sha1(buf.buf, onto_oid.hash)) {

I missed this last time but we could also replace `get_sha1` with `get_oid`

> +		strbuf_release(&buf);
> +		return error(_("need a HEAD to fixup"));
> +	}
> +	strbuf_release(&buf);
> +
> +	fd = open(todo_file, O_RDONLY);
> +	if (fd < 0) {
> +		return error_errno(_("could not open '%s'"), todo_file);
> +	}
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		return error(_("could not read '%s'."), todo_file);
> +	}
> +	close(fd);
> +	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
> +		todo_list_release(&todo_list);
> +		return -1;
> +	}
> +
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct todo_item *item = todo_list.items + i;
> +
> +		if (item->command >= TODO_NOOP)
> +			continue;
> +		if (item->command != TODO_PICK)
> +			break;
> +		if (parse_commit(item->commit)) {
> +			todo_list_release(&todo_list);
> +			return error(_("could not parse commit '%s'"),
> +				oid_to_hex(&item->commit->object.oid));
> +		}
> +		if (!item->commit->parents)
> +			break; /* root commit */
> +		if (item->commit->parents->next)
> +			break; /* merge commit */
> +		parent_oid = &item->commit->parents->item->object.oid;
> +		if (hashcmp(parent_oid->hash, oid->hash))
> +			break;
> +		oid = &item->commit->object.oid;
> +	}
> +	if (i > 0) {
> +		int offset = i < todo_list.nr ?
> +			todo_list.items[i].offset_in_buf : todo_list.buf.len;
> +		const char *done_path = rebase_path_done();
> +
> +		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
> +		if (fd < 0) {
> +			error_errno(_("could not open '%s' for writing"),
> +				    done_path);
> +			todo_list_release(&todo_list);
> +			return -1;
> +		}
> +		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
> +			error_errno(_("could not write to '%s'"), done_path);
> +			todo_list_release(&todo_list);
> +			close(fd);
> +			return -1;
> +		}
> +		close(fd);
> +
> +		fd = open(rebase_path_todo(), O_WRONLY, 0666);
> +		if (fd < 0) {
> +			error_errno(_("could not open '%s' for writing"),
> +				    rebase_path_todo());
> +			todo_list_release(&todo_list);
> +			return -1;
> +		}
> +		if (write_in_full(fd, todo_list.buf.buf + offset,
> +				todo_list.buf.len - offset) < 0) {
> +			error_errno(_("could not write to '%s'"),
> +				    rebase_path_todo());
> +			close(fd);
> +			todo_list_release(&todo_list);
> +			return -1;
> +		}
> +		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
> +			error_errno(_("could not truncate '%s'"),
> +				    rebase_path_todo());
> +			todo_list_release(&todo_list);
> +			close(fd);
> +			return -1;
> +		}
> +		close(fd);
> +
> +		todo_list.current = i;
> +		if (is_fixup(peek_command(&todo_list, 0)))
> +			record_in_rewritten(oid, peek_command(&todo_list, 0));
> +	}
> +
> +	todo_list_release(&todo_list);
> +	printf("%s\n", oid_to_hex(oid));
> +
> +	return 0;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index 878dd296f8c..04a57e09a1d 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -50,6 +50,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
>  
>  int transform_todo_ids(int shorten_ids);
>  int check_todo_list(void);
> +int skip_unnecessary_picks(void);
>  
>  extern const char sign_off_header[];
>  
> 

 - Liam 
