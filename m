Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024B21F404
	for <e@80x24.org>; Wed, 31 Jan 2018 14:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeAaOIa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 09:08:30 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35697 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeAaOI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 09:08:29 -0500
Received: by mail-qk0-f196.google.com with SMTP id 69so1674430qkz.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 06:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TNNwfGWOuWe4BKJSdM9TBAAVXJ45iPBsZSstFWi7hjw=;
        b=LcbShOMS8HKkrcHseWClTQR/+M8HqsLerKw0iPCpMKTenWtYzlpXwD9PXCS2lQJLHP
         Mp9SraJyfLrQ5kJ+SCy4Ne6UFMFc2NGfAxeMbvLSgDJvPBvYmpt+x6fQvihh3vnpQBhW
         ozPZYGg+SPuHAosLx5nbEMtdJ93qhjjx58jXb5eOp56tA3sBoeRF8iPTvgmpv1anQIMZ
         gEztsjbaIxMoqu5YX1iF0kX7IUFfA5uxiQZ0ZErXsVWAZ9hp5VHaedO4Flw0xYmgfwGD
         dxTX7w6I1/y0tdVi+hhMhJxGkRTpNuV7f1/vs2DUq8x1UAiFyEFhmFVOaVYke9aXpEvK
         tfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TNNwfGWOuWe4BKJSdM9TBAAVXJ45iPBsZSstFWi7hjw=;
        b=LHL6MS5rKaPfpgtIoAlBkcJVxF018KdGaqhCLoNR4/Ml96nsQjQZYT4wPPuhb1mhqN
         CPDpKp0i+lVNFEpZeydWb4asHwicOtFjrMAH7b1+aMQnDxJOGE5sOgUqQw98CfepcmJ4
         zaA9IWVJofCsMU+QwAR0rCMtuaJO7GO2dIZfllWd/2a2QcFGhG2A6jWXhErYGoHIG/gU
         OAx7yWxFuACtyCTlTcJBLZIEonuWxmX8P3ibgspavH28fYUSvjRJBuikrbZjeyWimCS8
         vTwpU3UcNwiOi23TZ0RMQzkQkTPOkVe6gqWt84p2DcuV6y9D2vuiZp009s1FpaIvlSVt
         sxcw==
X-Gm-Message-State: AKwxytfksO99UxbyshfjBU7khE2/vE8lbLxE1U4+D+pL0klfhr/yjDkD
        vWna721/54Oq54C7eFbTjjE=
X-Google-Smtp-Source: AH8x22578oB6FWU/hQtVa61r3Yw5VfrpahC2H4qrbu7h0pOSAIbtUlQGa57UZdQyIVYnsf77YT5okw==
X-Received: by 10.55.131.198 with SMTP id f189mr47641235qkd.250.1517407708910;
        Wed, 31 Jan 2018 06:08:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id a123sm10963644qkf.22.2018.01.31.06.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 06:08:28 -0800 (PST)
Subject: Re: [PATCH v2 05/27] upload-pack: factor out processing lines
To:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-6-bmwill@google.com>
 <CAGZ79kYbhR-y7WkhFgQ-YBkWaNXWuadDAGXaAzWDyJBzDSqc2w@mail.gmail.com>
 <20180126213338.GB17576@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8df41c05-c1bf-b834-2815-0dfe6b1c7b09@gmail.com>
Date:   Wed, 31 Jan 2018 09:08:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180126213338.GB17576@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2018 4:33 PM, Brandon Williams wrote:
> On 01/26, Stefan Beller wrote:
>> On Thu, Jan 25, 2018 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
>>> Factor out the logic for processing shallow, deepen, deepen_since, and
>>> deepen_not lines into their own functions to simplify the
>>> 'receive_needs()' function in addition to making it easier to reuse some
>>> of this logic when implementing protocol_v2.
>>>
>>> Signed-off-by: Brandon Williams <bmwill@google.com>
>>> ---
>>>   upload-pack.c | 113 ++++++++++++++++++++++++++++++++++++++--------------------
>>>   1 file changed, 74 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/upload-pack.c b/upload-pack.c
>>> index 2ad73a98b..42d83d5b1 100644
>>> --- a/upload-pack.c
>>> +++ b/upload-pack.c
>>> @@ -724,6 +724,75 @@ static void deepen_by_rev_list(int ac, const char **av,
>>>          packet_flush(1);
>>>   }
>>>
>>> +static int process_shallow(const char *line, struct object_array *shallows)
>>> +{
>>> +       const char *arg;
>>> +       if (skip_prefix(line, "shallow ", &arg)) {
>> stylistic nit:
>>
>>      You could invert the condition in each of the process_* functions
>>      to just have
>>
>>          if (!skip_prefix...))
>>              return 0
>>
>>          /* less indented code goes here */
>>
>>          return 1;
>>
>>      That way we have less indentation as well as easier code.
>>      (The reader doesn't need to keep in mind what the else
>>      part is about; it is a rather local decision to bail out instead
>>      of having the return at the end of the function.)
> I was trying to move the existing code into helper functions so
> rewriting them in transit may make it less reviewable?

I think the way you kept to the existing code as much as possible is 
good and easier to review. Perhaps a style pass after the patch lands is 
good for #leftoverbits.

>>
>>> +               struct object_id oid;
>>> +               struct object *object;
>>> +               if (get_oid_hex(arg, &oid))
>>> +                       die("invalid shallow line: %s", line);
>>> +               object = parse_object(&oid);
>>> +               if (!object)
>>> +                       return 1;
>>> +               if (object->type != OBJ_COMMIT)
>>> +                       die("invalid shallow object %s", oid_to_hex(&oid));
>>> +               if (!(object->flags & CLIENT_SHALLOW)) {
>>> +                       object->flags |= CLIENT_SHALLOW;
>>> +                       add_object_array(object, NULL, shallows);
>>> +               }
>>> +               return 1;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int process_deepen(const char *line, int *depth)
>>> +{
>>> +       const char *arg;
>>> +       if (skip_prefix(line, "deepen ", &arg)) {
>>> +               char *end = NULL;
>>> +               *depth = (int) strtol(arg, &end, 0);

nit: space between (int) and strtol?

>>> +               if (!end || *end || *depth <= 0)
>>> +                       die("Invalid deepen: %s", line);
>>> +               return 1;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int process_deepen_since(const char *line, timestamp_t *deepen_since, int *deepen_rev_list)
>>> +{
>>> +       const char *arg;
>>> +       if (skip_prefix(line, "deepen-since ", &arg)) {
>>> +               char *end = NULL;
>>> +               *deepen_since = parse_timestamp(arg, &end, 0);
>>> +               if (!end || *end || !deepen_since ||
>>> +                   /* revisions.c's max_age -1 is special */
>>> +                   *deepen_since == -1)
>>> +                       die("Invalid deepen-since: %s", line);
>>> +               *deepen_rev_list = 1;
>>> +               return 1;
>>> +       }
>>> +       return 0;
>>> +}
>>> +
>>> +static int process_deepen_not(const char *line, struct string_list *deepen_not, int *deepen_rev_list)
>>> +{
>>> +       const char *arg;
>>> +       if (skip_prefix(line, "deepen-not ", &arg)) {
>>> +               char *ref = NULL;
>>> +               struct object_id oid;
>>> +               if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
>>> +                       die("git upload-pack: ambiguous deepen-not: %s", line);
>>> +               string_list_append(deepen_not, ref);
>>> +               free(ref);
>>> +               *deepen_rev_list = 1;
>>> +               return 1;
>>> +       }
>>> +       return 0;
>>> +}
>>> +
>>>   static void receive_needs(void)
>>>   {
>>>          struct object_array shallows = OBJECT_ARRAY_INIT;
>>> @@ -745,49 +814,15 @@ static void receive_needs(void)
>>>                  if (!line)
>>>                          break;
>>>
>>> -               if (skip_prefix(line, "shallow ", &arg)) {
>>> -                       struct object_id oid;
>>> -                       struct object *object;
>>> -                       if (get_oid_hex(arg, &oid))
>>> -                               die("invalid shallow line: %s", line);
>>> -                       object = parse_object(&oid);
>>> -                       if (!object)
>>> -                               continue;
>>> -                       if (object->type != OBJ_COMMIT)
>>> -                               die("invalid shallow object %s", oid_to_hex(&oid));
>>> -                       if (!(object->flags & CLIENT_SHALLOW)) {
>>> -                               object->flags |= CLIENT_SHALLOW;
>>> -                               add_object_array(object, NULL, &shallows);
>>> -                       }
>>> +               if (process_shallow(line, &shallows))
>>>                          continue;
>>> -               }
>>> -               if (skip_prefix(line, "deepen ", &arg)) {
>>> -                       char *end = NULL;
>>> -                       depth = strtol(arg, &end, 0);
>>> -                       if (!end || *end || depth <= 0)
>>> -                               die("Invalid deepen: %s", line);
>>> +               if (process_deepen(line, &depth))
>>>                          continue;
>>> -               }
>>> -               if (skip_prefix(line, "deepen-since ", &arg)) {
>>> -                       char *end = NULL;
>>> -                       deepen_since = parse_timestamp(arg, &end, 0);
>>> -                       if (!end || *end || !deepen_since ||
>>> -                           /* revisions.c's max_age -1 is special */
>>> -                           deepen_since == -1)
>>> -                               die("Invalid deepen-since: %s", line);
>>> -                       deepen_rev_list = 1;
>>> +               if (process_deepen_since(line, &deepen_since, &deepen_rev_list))
>>>                          continue;
>>> -               }
>>> -               if (skip_prefix(line, "deepen-not ", &arg)) {
>>> -                       char *ref = NULL;
>>> -                       struct object_id oid;
>>> -                       if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
>>> -                               die("git upload-pack: ambiguous deepen-not: %s", line);
>>> -                       string_list_append(&deepen_not, ref);
>>> -                       free(ref);
>>> -                       deepen_rev_list = 1;
>>> +               if (process_deepen_not(line, &deepen_not, &deepen_rev_list))
>>>                          continue;
>>> -               }
>>> +
>>>                  if (!skip_prefix(line, "want ", &arg) ||
>>>                      get_oid_hex(arg, &oid_buf))
>>>                          die("git upload-pack: protocol error, "
>>> --
>>> 2.16.0.rc1.238.g530d649a79-goog
>>>

