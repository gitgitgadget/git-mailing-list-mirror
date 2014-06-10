From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Tue, 10 Jun 2014 05:35:08 -0700
Message-ID: <5396FB7C.6000709@gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com> <1402318146-5062-2-git-send-email-tanayabh@gmail.com> <CAPig+cTR5SdDF0QnKN8GFEKFkNEK_HoCDHj_vTnAbp37HK3kDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 14:35:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuLHJ-0002o9-DU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 14:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbaFJMfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 08:35:45 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48473 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaFJMfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 08:35:45 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so786926pdb.39
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=g/LhNoRYkp8CLJU9Xj5eQdJWED2Jcw14FQn4d2sPfOg=;
        b=JzEf5wLHSiEaNC01wo9AEgd8Q1+xbyBh3uQW/zWyaNMrlQFvD0vANESCBD9fDrNZ17
         s/PmsnXV0QHmhO9JlSbX8EAA5qT2LDsjoeJvUrWW2vqdphLznMDUavhrxo9vBN3X5qC/
         8fNpdbAuGmIUiDU55eniqglA5X2hosOcifnjkgFwbTza/UwosT0eKnFm4xUhjZimWepH
         NZEakyv/yvyjAwAipVPl9ZNC+v5Ah1cjf02h6Cw88FhNrFlJ+OSyoOgjocv3QgFWQmif
         u+G9LvY+RQX7+dqtFH3pgfYDr373yWSPbMigDjY6MyMG2Nic9xHDWJLkf3n2gl7USw6E
         vkQg==
X-Received: by 10.66.231.139 with SMTP id tg11mr5152329pac.87.1402403744551;
        Tue, 10 Jun 2014 05:35:44 -0700 (PDT)
Received: from [192.168.52.160] ([117.254.217.189])
        by mx.google.com with ESMTPSA id wl5sm69414121pbc.13.2014.06.10.05.35.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 05:35:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAPig+cTR5SdDF0QnKN8GFEKFkNEK_HoCDHj_vTnAbp37HK3kDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251183>

Hi,

Thanks for the review, Eric. I have replied to your comments below,
I will try to reply early and more promptly now.

On 06/10/2014 04:27 AM, Eric Sunshine wrote:
>> ---
>> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
>> index 230b3a0..5b6e376 100644
>> --- a/Documentation/technical/api-config.txt
>> +++ b/Documentation/technical/api-config.txt
>> @@ -77,6 +77,24 @@ To read a specific file in git-config format, use
>>  `git_config_from_file`. This takes the same callback and data parameters
>>  as `git_config`.
>>
>> +Querying For Specific Variables
>> +-------------------------------
>> +
>> +For programs wanting to query for specific variables in a non-callback
>> +manner, the config API provides two functions `git_config_get_string`
>> +and `git_config_get_string_multi`. They both take a single parameter,
>> +
>> +- a key string in canonical flat form for which the corresponding values
>> +  will be retrieved and returned.
> 
> It's strange to have a bulleted list for a single item. It can be
> stated more naturally as a full sentence, without the list.

Point Noted.

>> +They both read values from an internal cache generated previously from
>> +reading the config files. `git_config_get_string` returns the value with
>> +the highest priority(i.e. for the same variable value in the repo config
>> +will be preferred over value in user wide config).
>> +
>> +`git_config_get_string_multi` returns a `string_list` containing all the
>> +values for that particular key, sorted in order of increasing priority.
>> +
>>  Value Parsing Helpers
>>  ---------------------
>>
>> diff --git a/config.c b/config.c
>> index a30cb5c..6f6b04e 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -9,6 +9,8 @@
>>  #include "exec_cmd.h"
>>  #include "strbuf.h"
>>  #include "quote.h"
>> +#include "hashmap.h"
>> +#include "string-list.h"
>>
>>  struct config_source {
>>         struct config_source *prev;
>> @@ -37,6 +39,120 @@ static struct config_source *cf;
>>
>>  static int zlib_compression_seen;
>>
>> +struct config_cache_entry {
>> +       struct hashmap_entry ent;
>> +       char *key;
>> +       struct string_list *value_list;
> 
> Same question as in my v1 and v2 reviews [1][2], and reiterated by
> Matthieu [3]: Why is 'value_list' a pointer to a structure rather than
> just a structure?
> 

Sorry for the lack of response on this part. I thought choosing a pointer to a
structure or just the structure itself was a stylistic choice. Since most of the
functions just pass the pointer to this struct, I thought it would be more natural to
use it. But I have changed my mind on this one. In the next iteration I will be using
a plane old struct.

> 
>> +};
>> +
>> +static int hashmap_is_init;
>> +
>> +static int config_cache_set_value(const char *key, const char *value);
>> +
>> +static int config_cache_entry_cmp_case(const struct config_cache_entry *e1,
>> +                                const struct config_cache_entry *e2, const void *unused)
>> +{
>> +       return strcmp(e1->key, e2->key);
> 
> As suggested by Peff [4], this comparison is now case-sensitive,
> instead of case-insensitive as in the previous version. Rather than
> changing the appended '_icase' to '_case', a more typical function
> name would be simply config_cache_entry_cmp().

Noted.

>> +}
>> +
>> +static void config_cache_init(struct hashmap *config_cache)
>> +{
>> +       hashmap_init(config_cache, (hashmap_cmp_fn) config_cache_entry_cmp_case, 0);
> 
> In his review [4], Peff suggested giving config_cache_entry_cmp_case()
> the correct hashmap_cmp_fn signature so that this cast can be dropped.
> It's not clear whether you disagree with his advice or overlooked or
> forgot about it. If you disagree with his suggestion, it's okay to say
> so and explain why you feel the way you do, but without feedback from
> you, he or another reviewer is going to continue suggesting the same
> change.

Now on this one, I checked the code thoroughly. Every single hashmap_init()
incantation in git code has a hashmap_cmp_fn cast. I don't think that it is
necessary to do so. Is it?

>> +}
>> +
>> +static int config_cache_callback(const char *key, const char *value, void *unused)
>> +{
>> +       config_cache_set_value(key, value);
>> +       return 0;
>> +}
>> +
>> +static struct hashmap *get_config_cache(void)
>> +{
>> +       static struct hashmap config_cache;
>> +       if (!hashmap_is_init) {
>> +               config_cache_init(&config_cache);
>> +               hashmap_is_init = 1;
>> +               git_config(config_cache_callback, NULL);
>> +               return &config_cache;
> 
> Why do you 'return' here rather than just falling through to the
> 'return' outside the conditional?

Noted.

>> +static struct config_cache_entry *config_cache_find_entry(const char *key)
>> +{
>> +       struct hashmap *config_cache;
>> +       struct config_cache_entry k;
>> +       char *normalized_key;
>> +       int baselength = 0, ret;
>> +       config_cache = get_config_cache();
>> +       ret = git_config_parse_key(key, &normalized_key, &baselength);
> 
> Since you neither care about nor ever reference 'baselength', you
> should just pass NULL as the third argument.
> 

Noted.

>> +       if (ret)
>> +               return NULL;
>> +
>> +       hashmap_entry_init(&k, strhash(normalized_key));
>> +       k.key = (char*) key;
> 
> This looks fishy. You're hashing based upon 'normalized_key' but then
> comparing against the unnormalized 'key'. Peff's suggestion [4] was to
> store the normalized key in the hash, which means that you should use
> 'normalized_key' for both hashing and comparing. (See additional
> commentary about this issue below in config_cache_set_value().)

Ouch, this I had corrected in a future commit. But forgot to include in
this patch.

> Style: (char *)key

Noted. In function arguments the code uses (char*) key. I copied it from there.
:)

>> +       return hashmap_get(config_cache, &k, NULL);
> 
> You're leaking 'normalized_key', which git_config_parse_key()
> allocated on your behalf.
>
Noted. I will now check with valgrind before sending any future series.

>> +}
>> +
>> +static struct string_list *config_cache_get_value(const char *key)
>> +{
>> +       struct config_cache_entry *e = config_cache_find_entry(key);
>> +       return e ? e->value_list : NULL;
>> +}
>> +
>> +
>> +static int config_cache_set_value(const char *key, const char *value)
>> +{
>> +       struct hashmap *config_cache;
>> +       struct config_cache_entry *e;
>> +
>> +       config_cache = get_config_cache();
>> +       e = config_cache_find_entry(key);
>> +       if (!e) {
>> +               e = xmalloc(sizeof(*e));
>> +               hashmap_entry_init(e, strhash(key));
> 
> The hash computed to store the key should be the same as the hash to
> look it up. In config_cache_find_entry(), you're correctly computing
> the hash based upon the normalized key, but here you're doing so from
> the unnormalized key.
> 
>> +               e->key = xstrdup(key);
> 
> Likewise. Normalized keys should be stored in the hash, not unnormalized.
> 
> You should be invoking git_config_parse_key() to normalize the key
> both for hashing and storing.
> 
> Note, also, that call git_config_parse_key() allocates the normalize
> key on your behalf, so you do *not* want to xstrdup() it here.

config_cache_set_value() gets its values from git_config() as it the callback.
git_config() feeds the callback only normalized values by using functions like
get_extended_base_var(), get_base_var() etc. Thus, I didn't use
git_config_parse_key(). Please correct me if I am wrong, but I tested this case
thoroughly.

>> +               e->value_list = xcalloc(sizeof(struct string_list), 1);
>> +               e->value_list->strdup_strings = 1;
> 
> This code is perhaps too intimate with the implementation of
> string_list. It may work today (because it is safe to initialize all
> string_list fields to 0 via xcalloc()), but a future change to the
> string_list implementation may invalidate that assumption. The
> initialization macros in string-list.h exist to preserve the
> abstraction, so you don't have to know the details of initialization.
> The macros are not suitable for your use-case, but an initialization
> function, such as string_list_init(), would be suitable, and it would
> be appropriate to add such a function in a preparatory patch (as
> already suggested by [1]).

Noted. As I am going to use a simple struct for the list, this won't be
a problem.

>> +               string_list_append(e->value_list, value);
>> +               hashmap_add(config_cache, e);
>> +       } else {
>> +               string_list_append(e->value_list, value);
>> +       }
>> +       return 0;
>> +}
>> +
>> +extern const char *git_config_get_string(const char *key)
> 
> Drop the 'extern'. The header already declares it such.
>

Noted.

>> +{
>> +       struct string_list *values;
>> +       values = config_cache_get_value(key);
>> +       if (!values)
>> +               return NULL;
>> +       assert(values->nr > 0);
>> +       return values->items[values->nr - 1].string;
>> +}
>> +
>> +extern const struct string_list *git_config_get_string_multi(const char *key)
> 
> Drop the 'extern'. The header already declares it such.
> 

Noted.

>> +{
>> +       return config_cache_get_value(key);
>> +}
>> +
>>  static int config_file_fgetc(struct config_source *conf)
>>  {
>>         return fgetc(conf->u.file);
>> @@ -1700,6 +1816,12 @@ int git_config_set_multivar_in_file(const char *config_filename,
>>         lock = NULL;
>>         ret = 0;
>>
>> +       /* contents of config file has changed, so invalidate the
>> +        * config cache used by non-callback based query functions.
>> +        */
>> +       if (hashmap_is_init)
>> +               config_cache_free();
>> +
>>  out_free:
>>         if (lock)
>>                 rollback_lock_file(lock);
>> --
>> 1.9.0.GIT
> 
> [1]: http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html#a7611860
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/250566/focus=251058
> [3]: http://thread.gmane.org/gmane.comp.version-control.git/251073/focus=251079
> [4]: http://thread.gmane.org/gmane.comp.version-control.git/250566/focus=250618
> 
