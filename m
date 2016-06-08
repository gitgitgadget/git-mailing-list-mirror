From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/4] bisect--helper: `bisect_reset` shell function in C
Date: Wed, 8 Jun 2016 11:53:04 +0200
Message-ID: <CAP8UFD21gzXm3_yCHezA04zo+XFpF9TaGcMUm7y4FVK8RtekaQ@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-4-pranit.bauva@gmail.com> <CAPig+cSsMg5HznWGiUsngpHskSDMNhauvVw5jvaJTtEtJBw+ew@mail.gmail.com>
 <CAP8UFD2nfcMu7Gmh=asyu+WZh5X2UjhyYSC2Sbp-qsQVjEULcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 11:53:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAaAz-0002f1-QN
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 11:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424166AbcFHJxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 05:53:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33602 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbcFHJxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 05:53:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so1590269wmr.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lWoSLWT9derFzBYxXwtOBE8pzuLqyguYLz3ezDGLnkE=;
        b=Fz4oU6qV91nRvHOfD7DRi0BQ7kYckOkLviyHnv1ZLKYUyiuVGuvVjfTDtGGeBn49PZ
         ulk3wv5vMf/xJnO1l5Vteusc9hykOUKU6eCsPP0NPNc5a6Em3yysBjfP7UPxS+QyO0KY
         9PodHo7TTx7fPo7iF60wVzqZtXQuQl6JT/gv4S9pVjo4PRK7bPpZcOsChw3dOq1tLtiE
         dEXb8ljQGBIbAoLFQkiVHlp9RZ0tyjBSdtrF2KTR/3MRaSF+anEdQg9c4vcccuZ6p57q
         /ezqUxoRLi3l+IggKUa4eO+5L7EqQXzoeJX8+ddaER/dpmjXFJeLVLFQSDYifD8Mucnm
         sjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lWoSLWT9derFzBYxXwtOBE8pzuLqyguYLz3ezDGLnkE=;
        b=PmcDnD1LNW5bWN10InMgLU3SC0gyHOO3CDib+ERKqpKuRMapEIzfFfAqOe7s/RmSxf
         trVhrmsvUa5EIxRULmZ3v0iGjF9QS4nt2xDsdKIbFObKYADaGJGR4WGYxQphbzvdYgkB
         X4pV/N+ya1TI6qlvyFQOIFLHiyRo5LcvueTPl+KEmf6PD+oHsajcmskgOyR/tKYVuloa
         0asSql+3r1EVl8OC65eD617rejK9jXjJqT6Eonfrjuk9Tmu6b8OCeqAHpkFXSQJZLI6J
         5oLfSRmIGelKi8Q+zl144B7XgvvBrI4eT5bFXyipgptkaPf2vApRaZOvfKj9sTPl42gt
         P/bQ==
X-Gm-Message-State: ALyK8tIfm0ofJAiZrH+lFW2/uyXwtDfHgEaaArtQoHuwz75IgUzbvHWSpe1VTjlvwnelFjesYdpCx3eU5paCjQ==
X-Received: by 10.28.167.79 with SMTP id q76mr7436573wme.62.1465379585153;
 Wed, 08 Jun 2016 02:53:05 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Wed, 8 Jun 2016 02:53:04 -0700 (PDT)
In-Reply-To: <CAP8UFD2nfcMu7Gmh=asyu+WZh5X2UjhyYSC2Sbp-qsQVjEULcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296777>

On Wed, Jun 8, 2016 at 11:51 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Jun 8, 2016 at 9:59 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
>>> subcommand to `git bisect--helper` to call it from git-bisect.sh .
>>>
>>> Using `bisect_reset` subcommand is a temporary measure to port shell
>>> functions to C so as to use the existing test suite. As more functions
>>> are ported, this subcommand would be retired and will be called by some
>>> other method.
>>>
>>> Note: --bisect-clean-state subcommand has not been retired as there are
>>> still a function namely `bisect_start()` which still uses this
>>> subcommand.
>>>
>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>> ---
>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>> @@ -118,12 +122,51 @@ int bisect_clean_state(void)
>>> +int bisect_reset(const char *commit)
>>
>> s/^/static/
>>
>>> +{
>>> +       struct strbuf branch = STRBUF_INIT;
>>> +       int status = 0;
>>> +
>>> +       if (file_size(git_path_bisect_start()) < 1) {
>>
>> This doesn't even care about the size of the file, only if it
>> encountered an error while stat()'ing it. Why not just use
>> file_exists() instead (which you already use elsewhere in this
>> function)? Alternately, if you're trying to be faithful to the shell
>> code, then you *do* need to check that the file has non-zero size
>> before issuing the "not bisecting" diagnostic, so:
>>
>>     if ()

Ooops this was:

>>     if (file_size(git_path_bisect_start()) <= 0)

but I made a copy paste mistake, sorry.

>>         printf("... not bisecting ...");
>
> As file_size() returns an integer, there is no difference between
> "file_size(git_path_bisect_start()) <= 0" and
> "file_size(git_path_bisect_start()) < 1".
> Or am I missing something?
