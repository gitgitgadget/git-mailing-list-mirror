From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] cleanup submodule_config a bit.
Date: Wed, 12 Aug 2015 18:01:32 -0400
Message-ID: <CAPig+cT0+zh2v=NfB3RTwadfHoqB+VRTvbnMcdZ_g3RwtVzisg@mail.gmail.com>
References: <1439406838-6290-1-git-send-email-sbeller@google.com>
	<1439406838-6290-3-git-send-email-sbeller@google.com>
	<CAPig+cTcWME_U+nYATK7kK0vOSSCjJmGgXmUVmSawBiV5M+02g@mail.gmail.com>
	<CAGZ79kbV45LqxCha516dRNYAjAH71mxce6Xazvfmf1deLMzUxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Karsten Blees <karsten.blees@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:01:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPe5Z-0005oy-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbbHLWBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:01:34 -0400
Received: from mail-yk0-f196.google.com ([209.85.160.196]:36219 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbHLWBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:01:33 -0400
Received: by ykay144 with SMTP id y144so2056811yka.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JjX2+oYJi7XSziQiwYdGBDoPHMsklPszXnmg7Rhr18M=;
        b=AZ6+nVy3XHKTf8gfF1JjK0HYIS9+RfZ0T0aADI7ljj3br57qFb5YEZYloharONx9ZK
         GXDYOnfqFu+bRjzgqR2IXCIxY6qC3tkfkVekdJU3LBYobeTS+8wnOkZp2QqakF6eMcsS
         TFT/+FlZ13fs/CQdH2WS0VZ7Pf6b/E/yAfsRqkeK18sGT/LpMB40vXW4jkz2PQZ6/2xX
         Bjdcepk5sQq9wiPiG9HVTat1Be6BeNeaq2jMar7bPqPPxqmAcsrFq4yStUX+Tun/v1Us
         weMmxqdm4Ar40IMzUOA5CbdOC4+6y12sMpXntcC4rxG57JL3gpTFFRj84GKW6XnhV7gj
         9acQ==
X-Received: by 10.170.62.194 with SMTP id e185mr6825033yke.90.1439416892912;
 Wed, 12 Aug 2015 15:01:32 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Wed, 12 Aug 2015 15:01:32 -0700 (PDT)
In-Reply-To: <CAGZ79kbV45LqxCha516dRNYAjAH71mxce6Xazvfmf1deLMzUxQ@mail.gmail.com>
X-Google-Sender-Auth: SkQGQHuLgLSXIDLTFmv1q1IS97c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275820>

On Wed, Aug 12, 2015 at 5:34 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 12, 2015 at 2:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Aug 12, 2015 at 3:13 PM, Stefan Beller <sbeller@google.com> wrote:
>>>         if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
>>> -               return submodule;
>>> +               return NULL;
>>
>> There are a couple other places which return 'submodule' when it is
>> known to be NULL. One could rightly expect that they deserve the same
>> treatment, otherwise, the code becomes more confusing since it's not
>> obvious why 'return NULL' is used some places but not others.
>
> They were slightly less obvious to me, fixed now as well!
>
>>> @@ -420,14 +420,12 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>>>         switch (lookup_type) {
>>>         case lookup_name:
>>> -               submodule = cache_lookup_name(cache, sha1, key);
>>> -               break;
>>> +               return cache_lookup_name(cache, sha1, key);
>>>         case lookup_path:
>>> -               submodule = cache_lookup_path(cache, sha1, key);
>>> -               break;
>>> +               return cache_lookup_path(cache, sha1, key);
>>> +       default:
>>> +               return NULL;
>>>         }
>>> -
>>> -       return submodule;
>>
>> Earlier in the function, there's effectively a clone of this logic to
>> which you could apply the same transformation. Changing it here, while
>> ignoring the clone, makes the code more confusing (or at least
>> inconsistent) rather than less.
>
> Not quite. Note the `if (submodule)` in the earlier version, so in case
> cache_lookup_{name, path} return NULL, we keep going. The change I
> propose is at the end of the function and we definitely return no matter
> if it is NULL or not.

Okay, cache_lookup_{name, path}() can indeed return NULL, so the same
transformation won't work. Sorry for the noise.
