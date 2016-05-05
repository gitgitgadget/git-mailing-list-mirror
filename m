From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 5 May 2016 16:15:10 -0700
Message-ID: <CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySUO-00042b-0u
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbcEEXPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:15:16 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35179 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbcEEXPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:15:12 -0400
Received: by mail-io0-f174.google.com with SMTP id d62so99495684iof.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wZdQLRSgcp4wFlBp2q6ZvXEnl9lz6XBcNldf/AECfwA=;
        b=HB9l6bs/3h7oG1OH8yQowhDceLvyocYqjBITbDckImIiBZziMFzIfVtmjOb9xoBwG0
         Qzfzrzlyby7mwSG6LLqY2si6Y7ZQTP9h7KZGXFp5tbWYLEotuAQFss75VHRCHys3QIFi
         K5CsOk2NacYvmfK3/+7fcfjdt3kTvVhlWQfGBsmJ9NDtH1jJkIaqk91lStWcb5RRdWW0
         2gmVU3OzuuNt7Fdc0bSmd5ZGCTj8HnXJUsSPb0nqrNE3gB6h+0x5KSoc8FCJTqcI1y9C
         muo5kzxCIWHk7KrI6kc6hbtaWmfT8g9UWsg/E+N1uWK65r2fjxaUci6aMQl663szpWvC
         lkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wZdQLRSgcp4wFlBp2q6ZvXEnl9lz6XBcNldf/AECfwA=;
        b=XN7UWRBDe59uwmJwVD+qvgXd5zd7cjYOuQSMcj6K+jkrhdX7FRWnFB5SI3PacH7obb
         NhXpdXYYn4GHeH/N0zCk+Vlcua09wPkHqf8Ie3yPH3H5eFCmf09FRpVnUWy06reEAmWo
         McpwtZgOdWnpdamDVpHSEFj9LFV8jJKuDPfOGbi0TJUe74PkCXpaNo36NnH9XWEYRG63
         +MQ3KL3Llpxra8eN3HHGMOKLtesTqZmrGf2JDJZZ5FRBCeVBS2VV0uXp7F4PPDEgkQms
         JZX+Om357uMBT4CGAFOR6TxMSCwinzgL84jnUHsv0sKHy7imBCAUAxpgaAim9O57GcNi
         vwcQ==
X-Gm-Message-State: AOPr4FUATmnw7MBeBMTJxhtsP3NTX6Fiorpn9tTuMNtS99KVYRw0iKaWPPE/AiQABiuf6t6ren8pFXoJ1aTBBbcw
X-Received: by 10.107.161.68 with SMTP id k65mr22632382ioe.110.1462490110997;
 Thu, 05 May 2016 16:15:10 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 16:15:10 -0700 (PDT)
In-Reply-To: <xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293724>

On Thu, May 5, 2016 at 4:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> `check_path_for_gitlink` was introduced in 9d67b61f739a (2013-01-06,
>> add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse)
>> but the implementation was removed in 5a76aff1a6 (2013-07-14, add:
>> convert to use parse_pathspec).
>>
>> Remove the declaration from the header as well.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  pathspec.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/pathspec.h b/pathspec.h
>> index 0c11262..b596aed 100644
>> --- a/pathspec.h
>> +++ b/pathspec.h
>> @@ -96,7 +96,6 @@ static inline int ps_strcmp(const struct pathspec_item *item,
>>
>>  extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec);
>>  extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
>> -extern const char *check_path_for_gitlink(const char *path);
>>  extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
>>
>>  #endif /* PATHSPEC_H */
>
> Interesting.
>
> I wonder if the patches mentioned have something to do with the "git
> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
> repository in some way?

Which is considered a feature now. Maybe we should add tests for that?

http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb
