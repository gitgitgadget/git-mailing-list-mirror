Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E8CC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 18:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjC1SA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjC1SA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 14:00:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2AF12BD8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:00:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c2-20020a170903234200b001a0aecba4e1so8095001plh.16
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680026456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6t/3mSva+d2tqZQikzON4h+JHrjqzcelGHsfI/kgph4=;
        b=kLjPW9+GF8mXsjoHgwTm59LF9q161i/yXgM4TsOHXnIHkbderhNvykFbuNr5FzLhhB
         YufjCZ73KzSDuZLedtumPMZ2bE57Ok0FVq8eKb71451BW19Xi5Pnk1w6tm9W5ZX7R7vu
         DEaiQt6BvbpYm9WA07SP3Fe4P4pUb894QOTude6BPDaJzppgfhVFfkTwZ9P7qJkzVYPf
         lFTk4twAlfL4Swh9wFd4n52yKHMJR204cpfyLwwC+iWaNSVxrfam+CG0CZQkENyYn5tD
         wi/ABYFONQDanbYmUd2T5eh8nmvWbKj5cn5J24FQNobjkMMvhfkBXiMfV3UHG08hwEwi
         BcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6t/3mSva+d2tqZQikzON4h+JHrjqzcelGHsfI/kgph4=;
        b=i070rlKvQaz2ryFpAFrAmMdQVx6qCDml0Rykj7iHsA1RS6nrYBIl/PoUnKOoLR2oZA
         fRzVPMT1/Lna8b7KxuE6+lDbhOMHlXXlSHRF9y2LhjaLxhtwo38Z2fZAvs9IB7pbZnlf
         ges5yLkjQd3WLXdbUF3MsfPUiUgRUvtB5jDXYTOR7rTkBLXpSZUBihdwhgIkZ06b1lSw
         tRpIfTpdE7GMGahiDVEhVQH1GLQ9cUOAclOjQAsfSSDLHJHrKkfHMQIffvKUh0ai8ALv
         xohk806iJqTovyHg8Iz4YJHjU8LpSMYzsk8HPo0x2Xu4asOeiyNwuiwWQLxApjSBTBwd
         /JeA==
X-Gm-Message-State: AAQBX9c2GpdmOYBS4BJDc3LJQCl/HX6APb/I7C3lB6q0pf4c/rFQ1g8M
        6EruVnt0ZY89JmLusEaIviDNPGihawu+eQ==
X-Google-Smtp-Source: AKy350ZdTWxnnYZXpT9ePcOENawvBG/GYSgwF4vSApgSEFClSv2HwwJz7U9jMSaH1BCxmZlhd+a26ukh1kVPJQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:41c4:b0:1a0:1f4e:a890 with SMTP
 id u4-20020a17090341c400b001a01f4ea890mr6604697ple.1.1680026455914; Tue, 28
 Mar 2023 11:00:55 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:00:53 -0700
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
Message-ID: <kl6llejgdacq.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/8] config.c: use struct for config reading state
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Note to Junio: 8/8 (which renames "cs" -> "set") conflicts with
> ab/config-multi-and-nonbool. I previously said that I'd rebase this, but
> presumably a remerge-diff is more ergonomic + flexible (let me know if I'm
> mistaken), so I'll send a remerge-diff in a reply (I don't trust GGG not to
> mangle the patch :/).


  diff --git a/config.c b/config.c
  remerge CONFLICT (content): Merge conflict in config.c
  index b17658e1ba..159c404d0c 100644
  --- a/config.c
  +++ b/config.c
  @@ -2351,15 +2351,9 @@ void read_very_early_config(config_fn_t cb, void *data)
    config_with_options(cb, data, NULL, &opts);
  }

  -<<<<<<< HEAD
  -static struct config_set_element *configset_find_element(struct config_set *set, const char *key)
  -||||||| c000d91638
  -static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
  -=======
  RESULT_MUST_BE_USED
  -static int configset_find_element(struct config_set *cs, const char *key,
  +static int configset_find_element(struct config_set *set, const char *key,
            struct config_set_element **dest)
  ->>>>>>> gitster/ab/config-multi-and-nonbool
  {
    struct config_set_element k;
    struct config_set_element *found_entry;
  @@ -2392,15 +2386,9 @@ static int configset_add_value(struct config_reader *reader,
    struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
    int ret;

  -<<<<<<< HEAD
  -	e = configset_find_element(set, key);
  -||||||| c000d91638
  -	e = configset_find_element(cs, key);
  -=======
  -	ret = configset_find_element(cs, key, &e);
  +	ret = configset_find_element(set, key, &e);
    if (ret)
      return ret;
  ->>>>>>> gitster/ab/config-multi-and-nonbool
    /*
    * Since the keys are being fed by git_config*() callback mechanism, they
    * are already normalized. So simply add them without any further munging.
  @@ -2510,40 +2498,21 @@ int git_configset_get_value(struct config_set *set, const char *key, const char
    * queried key in the files of the configset, the value returned will be the last
    * value in the value list for that key.
    */
  -<<<<<<< HEAD
  -	values = git_configset_get_value_multi(set, key);
  -||||||| c000d91638
  -	values = git_configset_get_value_multi(cs, key);
  -=======
  -	if ((ret = git_configset_get_value_multi(cs, key, &values)))
  +	if ((ret = git_configset_get_value_multi(set, key, &values)))
      return ret;
  ->>>>>>> gitster/ab/config-multi-and-nonbool

    assert(values->nr > 0);
    *value = values->items[values->nr - 1].string;
    return 0;
  }

  -<<<<<<< HEAD
  -const struct string_list *git_configset_get_value_multi(struct config_set *set, const char *key)
  -||||||| c000d91638
  -const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
  -=======
  -int git_configset_get_value_multi(struct config_set *cs, const char *key,
  +int git_configset_get_value_multi(struct config_set *set, const char *key,
            const struct string_list **dest)
  ->>>>>>> gitster/ab/config-multi-and-nonbool
  -{
  -<<<<<<< HEAD
  -	struct config_set_element *e = configset_find_element(set, key);
  -	return e ? &e->value_list : NULL;
  -||||||| c000d91638
  -	struct config_set_element *e = configset_find_element(cs, key);
  -	return e ? &e->value_list : NULL;
  -=======
  +{
    struct config_set_element *e;
    int ret;

  -	if ((ret = configset_find_element(cs, key, &e)))
  +	if ((ret = configset_find_element(set, key, &e)))
      return ret;
    else if (!e)
      return 1;
  @@ -2557,12 +2526,12 @@ static int check_multi_string(struct string_list_item *item, void *util)
    return item->string ? 0 : config_error_nonbool(util);
  }

  -int git_configset_get_string_multi(struct config_set *cs, const char *key,
  +int git_configset_get_string_multi(struct config_set *set, const char *key,
            const struct string_list **dest)
  {
    int ret;

  -	if ((ret = git_configset_get_value_multi(cs, key, dest)))
  +	if ((ret = git_configset_get_value_multi(set, key, dest)))
      return ret;
    if ((ret = for_each_string_list((struct string_list *)*dest,
            check_multi_string, (void *)key)))
  @@ -2571,17 +2540,16 @@ int git_configset_get_string_multi(struct config_set *cs, const char *key,
    return 0;
  }

  -int git_configset_get(struct config_set *cs, const char *key)
  +int git_configset_get(struct config_set *set, const char *key)
  {
    struct config_set_element *e;
    int ret;

  -	if ((ret = configset_find_element(cs, key, &e)))
  +	if ((ret = configset_find_element(set, key, &e)))
      return ret;
    else if (!e)
      return 1;
    return 0;
  ->>>>>>> gitster/ab/config-multi-and-nonbool
  }

  int git_configset_get_string(struct config_set *set, const char *key, char **dest)
