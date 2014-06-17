From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v2 1/2] string-list: Add string_list initializer helper
 functions
Date: Tue, 17 Jun 2014 12:05:54 -0700
Message-ID: <53A09192.2030008@gmail.com>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com> <1402907232-24629-2-git-send-email-tanayabh@gmail.com> <xmqqsin4o406.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 21:06:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwyhr-0003Ry-NG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbaFQTGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:06:03 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:48474 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbaFQTGC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 15:06:02 -0400
Received: by mail-pd0-f174.google.com with SMTP id y10so5899865pdj.33
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uAGVBTdkRYuHj3I0yokjmakpJQLnUmSf69XJr4qDfjk=;
        b=m2MZ+YiLkDEa3sBUN23BIzo5UP3KLHq4kSSpBC/TD4m/iCTk/VCJGhdDye3KL35UjW
         OQNl8JVgisDR81U/gliBL262CDUYkxjChkjyJVO1lFpkqzhzSUZlFo7XgTQPez+atbkW
         f/scZa9wKXXsZ7+jrwc6ogw5qkRK932mIuroK2+FA6e9sQ8+aDhwzooEORhE6lgIVInp
         8l8ediFi3at7a02jrP2sCmF6fzeX4MOP/EODdImKHOYXqaOxQintwK1h/USBudoDxp3G
         ZpGoLzfVeYpdLgPEB4UlLabPuVOSqW9saPhmFIo6FmO2l4EOsf+6yoGtKmeOIu43w/JV
         HzTQ==
X-Received: by 10.66.254.198 with SMTP id ak6mr1683392pad.156.1403031961376;
        Tue, 17 Jun 2014 12:06:01 -0700 (PDT)
Received: from [192.168.52.164] ([117.254.223.152])
        by mx.google.com with ESMTPSA id dz4sm88969518pab.47.2014.06.17.12.05.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 12:06:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <xmqqsin4o406.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251937>

On 06/16/2014 03:59 PM, Junio C Hamano wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> When a compound construct like a string_list within another
>> struct is used, the default initializer macros are useless.
>> For such cases add helper functions for string_list
>> initialization for both DUP and NODUP modes.
>>
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
> 
> 
> Sorry, but I do not understand the above "useless".  Do you mean to
> say that xyzzy below cannot be initialized that way?
> 
>  git.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/git.c b/git.c
> index d261575..17714d1 100644
> --- a/git.c
> +++ b/git.c
> @@ -595,11 +595,24 @@ static int run_argv(int *argcp, const char ***argv)
>  }
>  
>  
> +#include "string-list.h"
> +
>  int main(int argc, char **av)
>  {
>  	const char **argv = (const char **) av;
>  	const char *cmd;
>  
> +	struct compound {
> +		int frotz;
> +		struct string_list nitfol;
> +	} xyzzy = {
> +		314,
> +		STRING_LIST_INIT_DUP,
> +	};
> +	printf("dup-strings is set to %s\n",
> +	       xyzzy.nitfol.strdup_strings ? "true" : "false");
> +	return 0;
> +
>  	startup_info = &git_startup_info;
>  
>  	cmd = git_extract_argv0_path(argv[0]);
> 

I was actually explaining for cases like below,

+struct config_cache_entry {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};

+static int config_cache_set_value(const char *key, const char *value)
+{
+	struct hashmap *config_cache;
+	struct config_cache_entry *e;
+
+	config_cache = get_config_cache();
+	e = config_cache_find_entry(key);
+	if (!e) {
+		e = xmalloc(sizeof(*e));
+		hashmap_entry_init(e, strhash(key));
+		e->key = xstrdup(key);
+		string_list_init_dup(&e->value_list);
+		string_list_append(&e->value_list, value);
+		hashmap_add(config_cache, e);
+	} else {
+		string_list_append(&e->value_list, value);
+	}
+	return 0;
+}

Here even if we use an initialization list as you have shown above, I would have to
check contents of 'struct hashmap_entry', thus totally breaking the encapsulation
that the string_list macro was providing. There may not be default values for
'struct hashmap_entry' as it may be using internal init function.

Also, I have to dynamically allocate the config_cache_entry struct, thus the
initialization list such as above cannot be used. Two previous reviewers of the
patch suggested I put a preparatory patch with string_list_init functions because
the default macros will be useless in my case.

Is there another way out?

Cheers,
Tanay abhra.
