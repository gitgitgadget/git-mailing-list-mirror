From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set
 API
Date: Thu, 31 Jul 2014 22:55:55 +0530
Message-ID: <53DA7C23.3090603@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com> <vpqr411bhd5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 31 19:26:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCu7B-0002lH-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 19:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaGaR0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 13:26:00 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38938 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaGaRZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 13:25:59 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so3850017pdb.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=i7idNVjMqmkoVbSgQ7b9zs0Ux6U26hy6M5V+h8PG/As=;
        b=IzFwd6FhQEjflf3+zBZXinW47w2VMgpX6p7BYOaSKJpDWpzEu4G8n5DQz002Z3Mbb2
         biY93H6ndyp35QuhI4CqNxMRCgvGdv5OEVrEcYV+FcI73SsnlQvhVSYaj5pvHG0bDj2j
         +Erm7faFuHv7/OLJ8ZCISDZQ4EuiSIQyYOm5H5zSHtVRdHHfldnRil77k8rQKXCWJsa0
         yj6qEbhDfFnTWoMoQpExNs2yoi9WO0PVHTXCiYzFvlSOe/rC/ZAWDz/9F/e6vXF2n8sN
         YyBAA47BWoI0VnejhrxCW+mX47aRhTSr9KSWbva8gpGQVDL42VjpIpsYmK8tVZ/0aD9H
         X8CQ==
X-Received: by 10.68.87.225 with SMTP id bb1mr6137327pbb.89.1406827558807;
        Thu, 31 Jul 2014 10:25:58 -0700 (PDT)
Received: from [127.0.0.1] ([223.229.21.143])
        by mx.google.com with ESMTPSA id wt2sm6107825pbc.93.2014.07.31.10.25.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 10:25:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqr411bhd5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254594>



On 7/31/2014 10:22 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> On 7/31/2014 9:25 PM, Matthieu Moy wrote:
>>> Tanay Abhra <tanayabh@gmail.com> writes:
>>>
>>>> +void git_die_config(const char *key)
>>>> +{
>>>> +	const struct string_list *values;
>>>> +	struct key_value_info *kv_info;
>>>> +	values = git_config_get_value_multi(key);
>>>> +	kv_info = values->items[values->nr - 1].util;
>>>> +	if (!kv_info->linenr)
>>>> +		die(_("unable to parse '%s' from command-line config"), key);
>>>> +	else
>>>> +		die(_("bad config variable '%s' at file line %d in %s"),
>>>> +			key,
>>>> +			kv_info->linenr,
>>>> +			kv_info->filename);
>>>> + }
>>>
>>> Extra whitespace before }.
>>>
>>> Also, didn't we agree that it was a good thing to factor this
>>> if/then/else into a helper function?
>>>
>>
>> I have been thinking about it, wouldn't it be better to give users
>> a function like,
>>
>> git_config_die_exact(key, value);
>>
>> where user supplies key & value both and it would print the correct message based
>> on that.
> 
> I suggested git_config_die_linenr(key, linenr), and I now realize it
> should take the value too.
> 
> You're suggesting git_config_die_exact(key, value). Is it a typo that
> you forgot the line number, or is it intentional? If intentional, I
> don't think it solves your issue:
> 
> [section]
>    key
>    key
>
> There are two errors in this file, and you need to provide a line
> number. key and value alone do not allow you to know which line the
> error is. You can use a convention like "complain on the first value
> equal to the argument", but I'm not sure that would always work. And
> that seems backward to me to reconstruct the line number since the
> function can be called from places where the line number is already
> known (while iterating over the string_list for example).

Still the user would have to know that the linenr info is there.
First hear my argument, then we can go either way.

Let's first see the previous code behavior, git_config() would die on the
first corrupt value, we wouldn't live to see the future value.

for example,

[section]
	key	// error(old git_config() would die here)
	key = good_value

[section]
	key	//again error

Now for the new behavior,

single valued callers use git_config_get_value() which will directly
supply the last value, so we don't see the first error value.
For such cases, git_die_config(key) is enough.

The new git_config() works exactly as the old code, it would die
on the first case of erroneous value. Here, git_die_config_exact(key, value)
would be enough.

The last case is git_config_get_value_multi(), here we iterate over the keys,
and then call git_die_config_exact(key, value) for the erroneous value.
(pros and cons: abstracts the error message implementation from the user
but there is an extra call to git_config_get_value_multi(), but its cheap and
we are dying anyway)

+	if (load_config_refs) {
+		values = git_config_get_value_multi("notes.displayref");
+		if (values) {
+			for (i = 0; i < values->nr; i++) {
+				if (!values->items[i].string) {
+					config_error_nonbool("notes.displayref");
+					git_die_config_exact("notes.displayref", values->items[i].string);
+				}
+				else
+					string_list_add_refs_by_glob(&display_notes_refs,
+								     values->items[i].string);
+			}
+		}
+	}

What do you think?
