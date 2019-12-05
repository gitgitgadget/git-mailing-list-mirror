Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	PDS_BTC_MSGID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12FC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD6206D9
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roSoQpt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfLEKlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:41:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38487 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfLEKk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 05:40:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so1426685pfc.5
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vSNqQFy2vZK+HVkviRWWijifC62/tHrgzr7ZlNx326c=;
        b=roSoQpt2oGPVpcYzJEQ6wV5D+AqPR5oju1Z0VQ9+8rYsQQfZFC7EUBYffNZpiNiRYC
         6mb9l1E6uwZ1fRTfvRjFeAlJ9aXvPbDe6i0ioEcJNOltsZyI+tQeRVTrf1WkHXoAyZUR
         QoiwNYC5S1tootIrsaXtPOv8+fAvk4lHwmTBmk2CoU6l7yigdlD9yjcFMuxpEtw4u1DW
         8gKeGKfNLONeiI/O3o/MF1GiMovZUCiwh8t4Gxwa+14sPyHrZqFsPfiFrhAq84KK6fsR
         S8O5gCGa8abWXipEwo7VKftUIc6phoM8y7hkQ3rDiak9E38MAoQUr7nt3MZkMjuvwvoy
         11Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vSNqQFy2vZK+HVkviRWWijifC62/tHrgzr7ZlNx326c=;
        b=Hq0dPHMa3e6kGpaZ4/hEbjEcetycSLjBmYE1oeqcnJJ+ys5JgLPurp3ECC8yx4XNLA
         mHWyJwh2xbAa5uL1KuL4fuIq0dOe0TH4Nvc3Ha3pkfLxb0ILuLeSnpAllnxY4uuszzSi
         QT+1+z8FPI7zGI1jTaYSPIXqy5Pty9NaCApnqxVcRdzvF2lHTt5BQyCmIJqjme/QIr1g
         2zr11QYXMxFzCZRAnJncnn+lc8V7SESZCakYEAkp0Wcel2ojp8DmNJieoZF6rpHjSD3/
         avdMgI1WnwGbcr9S8h11Qr6OCarJ7KCfPKsgevYBHBmQtrGnkoOix6eirbwiWiKqTCX5
         y7Vg==
X-Gm-Message-State: APjAAAUPFLZZuE+3zXQ943LEHL7GdtUB5Ll5YPDETh7qdsLxjOisZgYm
        ZPmYULNc//G78dEHnGLX/+Y6TXWg
X-Google-Smtp-Source: APXvYqxPJLe2YuaRUkpJrzh+62HasmTouvd2sWVqER9PgYGhzJ0zsnv2ONWjNE6ACSLYMkQW2EsRwQ==
X-Received: by 2002:a63:465b:: with SMTP id v27mr8745977pgk.257.1575542458901;
        Thu, 05 Dec 2019 02:40:58 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id m27sm11411125pff.179.2019.12.05.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 02:40:58 -0800 (PST)
Date:   Thu, 5 Dec 2019 02:40:56 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/11] git-p4: add new helper functions for python3
 conversion
Message-ID: <20191205104056.GA1192079@generichostname>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <f0e658b984ca009c575368e661016f785922f970.1575498577.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e658b984ca009c575368e661016f785922f970.1575498577.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 04, 2019 at 10:29:29PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.
> 
> Change the existing unicode test add new support functions for python2-python3 support.
> 
> Define the following variables:
> - isunicode - a boolean variable that states if the version of python natively supports unicode (true) or not (false). This is true for Python3 and false for Python2.
> - unicode - a type alias for the datatype that holds a unicode string.  It is assigned to a str under python 3 and the unicode type for Python2.
> - bytes - a type alias for an array of bytes.  It is assigned the native bytes type for Python3 and str for Python2.
> 
> Add the following new functions:
> 
> - as_string(text) - A new function that will convert a byte array to a unicode (UTF-8) string under python 3.  Under python 2, this returns the string unchanged.
> - as_bytes(text) - A new function that will convert a unicode string to a byte array under python 3.  Under python 2, this returns the string unchanged.
> - to_unicode(text) - Converts a text string as Unicode(UTF-8) on both Python2 and Python3.
> 
> Add a new function alias raw_input:
> If raw_input does not exist (it was renamed to input in python 3) alias input as raw_input.
> 
> The AS_STRING and AS_BYTES functions allow for modifying the code with a minimal amount of impact on Python2 support.  When a string is expected, the as_string() will be used to convert "cast" the incoming "bytes" to a string type. Conversely as_bytes() will be used to convert a "string" to a "byte array" type. Since Python2 overloads the datatype 'str' to serve both purposes, the Python2 versions of these function do not change the data, since the str functions as both a byte array and a string.

How come AS_STRING and AS_BYTES are all-caps here?

> 
> basestring is removed since its only references are found in tests that were changed in the previous change list.
> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit 7921aeb3136b07643c1a503c2d9d8b5ada620356)
> ---
>  git-p4.py | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 66 insertions(+), 4 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 0f27996393..93dfd0920a 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -32,16 +32,78 @@
>      unicode = unicode
>  except NameError:
>      # 'unicode' is undefined, must be Python 3
> -    str = str
> +    #
> +    # For Python3 which is natively unicode, we will use 
> +    # unicode for internal information but all P4 Data
> +    # will remain in bytes
> +    isunicode = True
>      unicode = str
>      bytes = bytes
> -    basestring = (str,bytes)
> +
> +    def as_string(text):
> +        """Return a byte array as a unicode string"""
> +        if text == None:

Nit: use `text is None` instead. Actually, any time you're checking an
object to see if it's None, you should use `is` instead of `==` since
there's usually only one None reference.

> +            return None
> +        if isinstance(text, bytes):
> +            return unicode(text, "utf-8")
> +        else:
> +            return text
> +
> +    def as_bytes(text):
> +        """Return a Unicode string as a byte array"""
> +        if text == None:
> +            return None
> +        if isinstance(text, bytes):
> +            return text
> +        else:
> +            return bytes(text, "utf-8")
> +
> +    def to_unicode(text):
> +        """Return a byte array as a unicode string"""
> +        return as_string(text)    
> +
> +    def path_as_string(path):
> +        """ Converts a path to the UTF8 encoded string """
> +        if isinstance(path, unicode):
> +            return path
> +        return encodeWithUTF8(path).decode('utf-8')
> +    

Trailing whitespace.

>  else:
>      # 'unicode' exists, must be Python 2
> -    str = str
> +    #
> +    # We will treat the data as:
> +    #   str   -> str
> +    #   bytes -> str
> +    # So for Python2 these functions are no-ops
> +    # and will leave the data in the ambiguious
> +    # string/bytes state
> +    isunicode = False
>      unicode = unicode
>      bytes = str
> -    basestring = basestring
> +
> +    def as_string(text):
> +        """ Return text unaltered (for Python3 support) """

I didn't mention this in earlier emails but it's been bothering me a
lot: is there any reason why you write it as "Python3" vs. "Python 3"
sometimes (and Python2 as well)? If there's no difference, then we
should probably stick to one variant in both the commit messages and in
the code. (I prefer the spaced variant.)

> +        return text
> +
> +    def as_bytes(text):
> +        """ Return text unaltered (for Python3 support) """
> +        return text
> +
> +    def to_unicode(text):
> +        """Return a string as a unicode string"""
> +        return text.decode('utf-8')
> +    

Trailing whitespace.

> +    def path_as_string(path):
> +        """ Converts a path to the UTF8 encoded bytes """
> +        return encodeWithUTF8(path)
> +
> +
> + 

Trailing whitespace.

> +# Check for raw_input support
> +try:
> +    raw_input
> +except NameError:
> +    raw_input = input
>  
>  try:
>      from subprocess import CalledProcessError
> -- 
> gitgitgadget
> 
