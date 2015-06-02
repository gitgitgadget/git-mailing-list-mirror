From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFCv2 01/16] stringlist: add from_space_separated_string
Date: Tue, 2 Jun 2015 11:10:49 -0400
Message-ID: <CAPig+cTsBU2t=NJEe16N2CMyYrWgbP-NvoKxNQ9QdPiokXj+hw@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-2-git-send-email-sbeller@google.com>
	<CACsJy8BEEvgP_YzVnbPaLL9QBs48sd2fn6CeicXD_9U92=9UnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:11:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YznqR-0007Ga-M7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 17:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759247AbbFBPKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 11:10:55 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38861 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759204AbbFBPKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 11:10:50 -0400
Received: by igblz2 with SMTP id lz2so12990210igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yFPuaA1W3TWOaTc6o0Ob98fJZ4BI03euM9kttBQ2GgU=;
        b=WUp6FcgdoGrDInKwFzENfsv8m524S2s85cA09z5WQr3IRNb8WApzstqBfpOkLYw1tZ
         OXRZbyouXcL+xaAJ1SEuMEBcoKWLkIQvfnCO6kIMkrKtSHhWrqy5yqbma70iREJ53y/l
         COG8qPmDr11n5BkBnemI1b4k1tdFwn+AZZjyn81BisqFpZ6O1duN7jj4Fal2Dpm7tPlE
         A6b5CxZMhoSLhCnfhWddrsxplFe5x88q7znuMV1k112NtYRqF8RBPM4xe1RiAuj4pYcp
         Gxk6SIGzEZZkQnZZiyKKQH4+pVbkGSPI+EdrPxOC5wZJ9r6Hp+TvTq8fjIHqD+s82h1U
         ebow==
X-Received: by 10.50.79.202 with SMTP id l10mr20983383igx.7.1433257849475;
 Tue, 02 Jun 2015 08:10:49 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 08:10:49 -0700 (PDT)
In-Reply-To: <CACsJy8BEEvgP_YzVnbPaLL9QBs48sd2fn6CeicXD_9U92=9UnA@mail.gmail.com>
X-Google-Sender-Auth: fnTV_w1jiJVbf49g7-okKYngwVo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270554>

On Tue, Jun 2, 2015 at 5:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
>> diff --git a/string-list.h b/string-list.h
>> index d3809a1..88c18e9 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -19,6 +19,7 @@ struct string_list {
>>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>>
>>  void string_list_init(struct string_list *list, int strdup_strings);
>> +void from_space_separated_string(struct string_list *list, char *line);
>
> The name feels out of place. All functions in here have "string_list"
> somewhere in their names. The implementation looks very close to
> string_list_split() but that name's already taken.. Maybe
> string_list_split_by_space()?

Indeed. If you really want to go the specialized route, splitting only
on whitespace, then Duy's suggestion makes sense. Alternately,
string_list_split_ws() might be easily understood while still
remaining somewhat terse.

However, why make this so specialized? A more generalized function
could be more widely useful. For instance, you could introduce a
function very similar to string_list_split() to which you supply
multiple delimiter characters (as a 'const char *') rather than the
single delimiter character accepted by string_list_split(). The
function could be named string_list_split_any() or
string_list_tokenize().

Also, it's ugly and inconvenient to require the incoming string be
non-const, and feels as if you're letting the interface be dictated by
an implementation detail (underlying use of strtok_r).
