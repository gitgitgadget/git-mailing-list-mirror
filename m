From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] gitweb: Add an option for adding more branch refs
Date: Wed, 27 Nov 2013 15:38:11 -0500
Message-ID: <CAPig+cR3hoWmDPJyWP6HbpuDvRwgdNj5VwX8A20DCfRBK5OuSQ@mail.gmail.com>
References: <1385566221-7977-1-git-send-email-krzesimir@endocode.com>
	<CAPig+cT=P3ZC9j-WwQjr7gu6RrNgLrXsPkiVmdy5OGYfu8mPqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 21:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VllsL-0007x9-27
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 21:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757830Ab3K0UiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 15:38:13 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46678 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791Ab3K0UiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 15:38:11 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so13162081iej.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 12:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=95z1cBCsXiEs34Jep1B3bgrdQ0UbB6wwPqnKc+wU1F4=;
        b=lKDFFMX97vzVhfMnvhgyHbxMilu5q0jNlsTZaEjKg3Q5NRPBTQZRN7L1Eed8oyInpL
         wMF/1r55bPAEmtDBGHdeKaJ7CVjqanPtAqiwwzSQpZ3ACIuju+aRIVkyt/Q5wBFmioG8
         yoRacq/bdnyGdbz6LzX7yDjiaLetNWqa4BXAaAtecmrXq2cuGn6l/bPKM9Bw6UhirMX5
         1slzWbXaX1KV6C0vD9QWI9CpMgM0vWJLjcx9wyOvNASwNpiBFv++lt4hQaDug3FVyNxV
         9jr1U8SBLfQB04Pn+N1ymwgAuF40RSOhlnFcJdsm45i5QLXcNfPIdmYMjV9om2H8I18l
         ax7Q==
X-Received: by 10.50.131.163 with SMTP id on3mr23168340igb.46.1385584691446;
 Wed, 27 Nov 2013 12:38:11 -0800 (PST)
Received: by 10.64.250.198 with HTTP; Wed, 27 Nov 2013 12:38:11 -0800 (PST)
In-Reply-To: <CAPig+cT=P3ZC9j-WwQjr7gu6RrNgLrXsPkiVmdy5OGYfu8mPqA@mail.gmail.com>
X-Google-Sender-Auth: c_iqiHZypv0IPQz5N8LoJVQ9tk4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238463>

On Wed, Nov 27, 2013 at 3:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Nov 27, 2013 at 10:30 AM, Krzesimir Nowak
> <krzesimir@endocode.com> wrote:
>> Overriding an @additional_branch_refs configuration variable with
>> value ('wip') will make gitweb to show branches that appear in
>> refs/heads and refs/wip (refs/heads is hardcoded). Might be useful for
>> gerrit setups where user branches are not stored under refs/heads/.
>>
>> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
>> ---
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 68c77f6..499281b 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -680,6 +688,19 @@ sub read_config_file {
>>         return;
>>  }
>>
>> +# performs sanity checks on parts of configuration.
>> +sub config_sanity_check {
>> +       # check additional refs validity
>> +       my %unique_branch_refs = ();
>> +       for my $ref (@additional_branch_refs) {
>> +               die_error(500, 'Invalid ref in @additional_branch_refs') unless (validate_ref($ref));
>
> Mentioning $ref in the error message would help the user resolve the
> problem more quickly.
>
>> +               die_error(500, '"heads" specified in @additional_branch_refs') if ($ref eq 'heads');
>
> Rephrasing this as
>
>     "heads" disallowed in @additional_branch_refs
>
> would better explain the problem to a user who has only made a cursory
> read of the documentation.

The program could easily filter out the redundant 'heads', so does
this really deserve a diagnostic?
