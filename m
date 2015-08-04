From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] remote: add get-url subcommand
Date: Mon, 3 Aug 2015 20:45:11 -0400
Message-ID: <CAPig+cSNNtNP93U6jy3X424FV3SRvoLr3PZaYe3m+auOM+gWcA@mail.gmail.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<1438635614-11174-1-git-send-email-mathstuf@gmail.com>
	<1438635614-11174-2-git-send-email-mathstuf@gmail.com>
	<CAPig+cQO_jXZmJG=EccwQ408TiAk7_BiQF1UKA31phXF7CXy6w@mail.gmail.com>
	<20150804001631.GA10416@megas.kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 02:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMQM3-0004W7-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 02:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbbHDApM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 20:45:12 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33188 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbbHDApL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 20:45:11 -0400
Received: by ykoo205 with SMTP id o205so35115388yko.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JYaRAtRL0C4lDsfCVSroN6vBqsvD5IqSstYV1ZIIj0M=;
        b=dLJdV+Y91PEvrmvVR7Au0OaZRQyQKyUxbG2QT8WTAy/VoMWb/nyKt6R3BGMTcY/AqA
         buPdk/2EnCMpxTB3unIOkiVnh7n7N4dxyo/1ff6GfbmCfx/E69vy+j4qdrMT9Y6J3GK/
         U0j8jT8e2bZvf/rtPx7VEJqh6pC2l+nKaSTdwCq5MTWeMD8k24oO4zbulTO2uCrnsF2X
         jYTXd6tqXNub65kY+R9kRBvt6Twx3ubFvBDPDr44GXap9KRUW9Vfco5TRhDJl8GKEt+b
         B90MMP7gZhgUKAvk9nuOI6eoYVFR1ociTRNVOfVma9m8/FKsXz9/eRQQIsQHHpSF+tn5
         Pa5A==
X-Received: by 10.13.192.132 with SMTP id b126mr843091ywd.163.1438649111200;
 Mon, 03 Aug 2015 17:45:11 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 3 Aug 2015 17:45:11 -0700 (PDT)
In-Reply-To: <20150804001631.GA10416@megas.kitware.com>
X-Google-Sender-Auth: 8H89bFsYh4nn0GbFrriCDuLLKX0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275233>

On Mon, Aug 3, 2015 at 8:16 PM, Ben Boeckel <mathstuf@gmail.com> wrote:
> On Mon, Aug 03, 2015 at 19:38:15 -0400, Eric Sunshine wrote:
>> On Mon, Aug 3, 2015 at 5:00 PM, Ben Boeckel <mathstuf@gmail.com> wrote:
>> > +       argc = parse_options(argc, argv, NULL, options, builtin_remote_geturl_usage,
>> > +                            PARSE_OPT_KEEP_ARGV0);
>>
>> What is the reason for PARSE_OPT_KEEP_ARGV0 in this case?
>
> Copied from get-url; I presume for more natural argv[] usage within the
> function.
>
>> > +       if (argc < 1 || argc > 2)
>> > +               usage_with_options(builtin_remote_geturl_usage, options);
>>
>> So,  'argc' must be 1 or 2, which in 'argv' terms is argv[0] and argv[1]).
>>
>> > +       remotename = argv[1];
>>
>> But here, argv[1] is accessed unconditionally, even though 'argc' may
>> have been 1, thus out of bounds.
>
> Yep, should be (argc < 2 || argc > 2) (or 1 if PARSE_OPT_KEEP_ARGV0 is
> removed). Off-by-one when converting from get-url.

Or, expressed more naturally:

    if (argc != 1)
        usage_with_options(...);

assuming the unnecessary PARSE_OPT_KEEP_ARGV0 is dropped.

> I'll reroll tomorrow morning in case there are more comments until then
> (particularly about PARSE_OPT_KEEP_ARGV0).

This new code doesn't take advantage of it, and it's very rarely used
in Git itself, thus its use here is a potential source of confusion,
so it's probably best to drop it. (The same could be said for
set_url(), but that's a separate topic.)
