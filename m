Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1699920401
	for <e@80x24.org>; Thu, 15 Jun 2017 18:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbdFOSPC (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 14:15:02 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36506 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbdFOSPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 14:15:00 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so10903258pff.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 11:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SIHkV8XKeur0b5YZi4o3oUf9t9ehxSZC3cmURpJLgos=;
        b=MoK5hcX2D2QsWsTSNFDTXoy5U4v3hhfZaHfm7gw1ns9DnQNvhJOpKW461LvRgbGgDS
         suWcGiRny+JAYbyHlmiPm6Tcjo/P40fQPRBTTBVT/OL2slI+NfCPpHURBZypKAB5mOzN
         EMj9PuKj/1eE+3bn5rYGMFnP7Osf0orPdZGyoE5hCBCOHjYMHDBfeMgPf53cvk67+Mcr
         NIi8NOg/NnwUWcM+FhIHyzXFyAqIaScDaCKRcD8NA2jNXxAJ8tEc2v59tnudj3p7XGvO
         zdBUL24SE3IwaB9RBi4+MFXmwunaqKuy9/d3dBQD560KtX/mQ7/uoHfyOtpNvitipbM9
         hHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SIHkV8XKeur0b5YZi4o3oUf9t9ehxSZC3cmURpJLgos=;
        b=OAQ29k4RoeFn/uVJ9e8daJLbgzOQMNmPiFmCTk1JkS22GRNR8HrDFgG16DfxrJhQPE
         9MW3j5WFJQTVG2jI+7QCuFhjxNogZa9FOpwwBKYXVStVDeySe1POV3FcGsbf3CRgfF4I
         HE3jxlT9CbQPu31ewHLN+NJTr7R7L90iUtdYCYQoDS4jlN9k7G4vIpHOuvwjH6+W+mG6
         gcnqvPSgMTljqvT8oQH3nYOz2oSK9bCEN5a2aXgT2d4eYtC0F52GZlYghvpiMsuJEOzZ
         gfIIHXi1dEvDQKKdZYZAgPvlhyhmxerFwW5OBsrNrlQwsXGBm4Zz7Hx8h8BsiGnc+Vxe
         +kYA==
X-Gm-Message-State: AKS2vOze1jXvQcCDCofHK/H1lJvJC54NKt3lF+JU7Y/e5HEG5IZh0YtS
        DXmh105D4SFUbtnf
X-Received: by 10.99.44.143 with SMTP id s137mr6508500pgs.183.1497550494035;
        Thu, 15 Jun 2017 11:14:54 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a05c:fb80:1fb9:b013])
        by smtp.gmail.com with ESMTPSA id r77sm1405927pfg.95.2017.06.15.11.14.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 11:14:53 -0700 (PDT)
Date:   Thu, 15 Jun 2017 11:14:47 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 3/4] sha1_file: consolidate storage-agnostic object
 fns
Message-ID: <20170615111447.1208e02b@twelve2.svl.corp.google.com>
In-Reply-To: <xmqq7f0d2l8p.fsf@gitster.mtv.corp.google.com>
References: <cover.1497387713.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497387713.git.jonathantanmy@google.com>
        <33a75a60b1d4298ec0af21c0df19e12bb0e43e2d.1497387714.git.jonathantanmy@google.com>
        <xmqq7f0d2l8p.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 15 Jun 2017 10:50:46 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Looking at the 3 primary functions (sha1_object_info_extended,
> > read_object, has_sha1_file_with_flags), they independently implement
> > mechanisms such as object replacement, retrying the packed store after
> > failing to find the object in the packed store then the loose store, and
> > being able to mark a packed object as bad and then retrying the whole
> > process. Consolidating these mechanisms would be a great help to
> > maintainability.
> >
> > Therefore, consolidate all 3 functions by extending
> > sha1_object_info_extended() to support the functionality needed by all 3
> > functions, and then modifying the other 2 to use
> > sha1_object_info_extended().
> 
> This is a rather "ugly" looking patch ;-) but I followed what
> has_sha1_file_with_flags() and read_object() do before and after
> this change, and I think this patch is a no-op wrt their behaviour
> (which is a good thing).
> 
> But I have a very mixed feelings on one aspect of the resulting
> sha1_object_info_extended().
> 
> >  int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
> >  {
> > ...
> >  	if (!find_pack_entry(real, &e)) {
> >  		/* Most likely it's a loose object. */
> > -		if (!sha1_loose_object_info(real, oi, flags)) {
> > +		if (oi && !sha1_loose_object_info(real, oi, flags)) {
> >  			oi->whence = OI_LOOSE;
> >  			return 0;
> >  		}
> > +		if (!oi && has_loose_object(real))
> > +			return 0;
> 
> This conversion is not incorrect per-se.  
> 
> We can see that has_sha1_file_with_flags() after this patch still
> calls has_loose_object().  But it bothers me that there is no hint
> to future developers to warn that a rewrite of the above like this
> is incorrect:
> 
>         if (!find_pack_entry(read, &e)) {
>                 /* Most likely it's a loose object. */
>        +        struct object_info dummy_oi;
>        +        if (!oi) {
>        +                memset(&dummy_oi, 0, sizeof(dummy_oi);
>        +                oi = &dummy_oi;
>        +        }
>        -        if (oi && !sha1_loose_object_info(real, oi, flags)) {
>        +        if (!sha1_loose_object_info(real, oi, flags)) {
>                         oi->whence = OI_LOOSE;
>                         return 0;
>                 }
>        -        if (!oi && has_loose_object(real))
>        -                return 0;
> 
> It used to be very easy to see that has_sha1_file_with_flags() will
> call has_loose_object() when it does not find the object in a pack,
> which will result in the loose object file freshened.  In the new
> code, it is very subtle to see that---it will happen when the caller
> passes oi == NULL, and has_sha1_file_with_flags() is such a caller,
> but it is unclear if there are other callers of this "consolidated"
> sha1_object_info_extended() that passes oi == NULL, and if they do
> also want to freshen the loose object file when they do so.

Good point - sorry, I didn't pay much attention to the freshening
behavior. After some thought, I now think it might be better to avoid
modifying has_sha1_file_with_flags(). As it is,
sha1_object_info_extended() already needs special handling (special
flags and handling the possibility of "oi" being NULL) to handle the
functionality required by has_sha1_file_with_flags(); adding yet another
thing to handle (freshen or not) would make it much too complicated.

This means that subsequent patches that modify the handling of
storage-agnostic objects would still need to modify 2 functions, but at
least that is fewer than the current 3.

I'll reroll with these changes so that you (and others) can see what it
looks like.

> > @@ -3480,18 +3491,12 @@ int has_sha1_pack(const unsigned char *sha1)
> >  
> >  int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
> >  {
> > -	struct pack_entry e;
> > +	int f = OBJECT_INFO_SKIP_CACHED |
> > +		((flags & HAS_SHA1_QUICK) ? OBJECT_INFO_QUICK : 0);
> >  
> >  	if (!startup_info->have_repository)
> >  		return 0;
> > -	if (find_pack_entry(sha1, &e))
> > -		return 1;
> > -	if (has_loose_object(sha1))
> > -		return 1;
> > -	if (flags & HAS_SHA1_QUICK)
> > -		return 0;
> > -	reprepare_packed_git();
> > -	return find_pack_entry(sha1, &e);
> > +	return !sha1_object_info_extended(sha1, NULL, f);
> >  }
> 
> I would have preferred to see the new variable not to be called 'f',
> as that makes it unclear what it is (is that a callback function
> pointer?).  In this case, uyou are forcing the flag bits passed
> down, so perhaps you can reuse the same variable?  
> 
> If you allocated a separate variable because
> has_sha1_file_with_flags() and sha1_object_info_extended() take flag
> bits from two separate vocabularies, that is a valid reasoning, but
> if that is the case, then I would have named 'f' to reflect that
> fact that this is different from parameter 'flag' that is defined in
> the has_sha1_file_with_flags() world, but a different thing that is
> defined in sha1_object_info_extended() world, e.g. "soie_flag" or
> something like that.
> 
> Thanks.

This makes sense. If I don't end up reverting
has_sha1_file_with_flags(), I'll change the name to "soie_flag".
