From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Wed, 8 Jun 2016 04:02:42 -0400
Message-ID: <CAPig+cTiqRAnhBx6eCifdOmES1uD3piPYgsRHNMVFCO07W1nTg@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com> <CAFZEwPMJbKAOdffWs7QedB+4j32LaBZeV1iGpUuGntMjXeN3hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:02:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYRv-0006v9-3X
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbcFHICq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:02:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36739 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbcFHICo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:02:44 -0400
Received: by mail-io0-f196.google.com with SMTP id f128so346954iof.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=62vlAx6N1oXO3zQfnnws8803LuIGLvU9eqhyMOXX/ms=;
        b=i4Bi00G5Q47w7tOkdjXfWZgOeCB2Ll1t4DV01CzMyk54tBwMNim2bDNozNlzKWP+s1
         nUZV0h+4TtWs6kphyEICCEpsvjOyJriqgLKe89/39UBBAhJqxCFNZaC9IiHCRNCo0SNy
         VPSOV3qYNAcS2fgkeJfXw14VJcNAGTaGCTP0tmrV4JE6ewfgxzzZGgWn3SH9SYhkBkYm
         zNutFYpNiYT6vwiwI69EHx7apCBMNv2RlNnHkXopjWCQH8klA6/BDH1J7Zq0ifFI+bh9
         ckUYXIXoXDMtJ//OaSskezJ3ecd2LaCY4eFUqwmxUnOo6JbbYYdaPE+V3zaNues3MkSH
         TmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=62vlAx6N1oXO3zQfnnws8803LuIGLvU9eqhyMOXX/ms=;
        b=hhaKb5VDUg+c0MM7s8cMd0PPAjcVcLSCSVoLo1vTRee36XM9P5YHX9k8e6xuRuj8hC
         E5A+ct10wgHnn+9o/WsgUD7G2rKSG3O5CINutUSR8Hu9SlQ8uqhzzx+juZ76DG+p9Rt5
         EFuhc9j5gzZx8L+Wedc2WSuTJL3HPktBlFZlarZo40NbNty1Rm2H4BgE8BsS5E7fK3iS
         woOF9WJE8QY2CMRyk++Q6SL6BaRiQ6zwWNs8MU50qm5ixxCAAdkk/wqhTBZeOGBgCM3/
         k62Pf6OpB85FqovbQgersQ3rsKPbqI0e4j19l4+YmPA5px2oxg2sMf2Wv5F3LIQcYMWU
         gIdw==
X-Gm-Message-State: ALyK8tIQrnCuE9k4iFNY5MbQCU01JUoWfs9ZUyYpKTWbVpks2uv5R+wkpribgpVkCSmozfG2a1FYnjddt612zw==
X-Received: by 10.107.132.40 with SMTP id g40mr6619887iod.34.1465372963222;
 Wed, 08 Jun 2016 01:02:43 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 01:02:42 -0700 (PDT)
In-Reply-To: <CAFZEwPMJbKAOdffWs7QedB+4j32LaBZeV1iGpUuGntMjXeN3hg@mail.gmail.com>
X-Google-Sender-Auth: koXd2vrlQ0fIwnmJJPNND65ST58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296764>

On Wed, Jun 8, 2016 at 3:46 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Jun 8, 2016 at 4:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> +       struct string_list *refs = cb_data;
>>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>>
>> Here you're allocating a string...
>>
>>> +       string_list_append(refs, ref);
>>> +       return 0;
>>> +}
>>> +
>>> +int bisect_clean_state(void)
>>> +{
>>> +       int result = 0;
>>> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>>
>> ...and the allocated string gets inserted into a string_list which
>> itself duplicates the string (STRING_LIST_INIT_DUP), so this is
>> leaking the string you created with xstrfmt(), isn't it?
>
> Yes nice catch. I would prefer using the string_list with
> STRING_LIST_INIT_DUP and free the ref.

That's unnecessarily wasteful. Better would be to to use STRING_LIST_INIT_NODUP.
