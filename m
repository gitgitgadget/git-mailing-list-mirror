From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v9 3/4] contrib: related: add option to parse from committish
Date: Mon, 3 Jun 2013 16:05:17 -0500
Message-ID: <CAMP44s2+rNG+VPVJ82UsfrmHugnUwBVJfYF5QRVn0=JC061RFg@mail.gmail.com>
References: <1369986380-412-1-git-send-email-felipe.contreras@gmail.com>
	<1369986380-412-4-git-send-email-felipe.contreras@gmail.com>
	<7v8v2rdnh0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 23:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbwY-0003hS-1K
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 23:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714Ab3FCVFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 17:05:22 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:47642 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635Ab3FCVFU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 17:05:20 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so990394lab.14
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D66GRIBKs7oogQT+HVlJGPUm2pbTNg26esMeDT4qCcA=;
        b=HzUaUBxViTAp9myZg9iR/de5w0AdicBtGNVtguRPfm1uvOn2/tstvnBNxHz3zG0KbY
         KlVHFBfhPcGJV4MTFK7XwoygUrg0RXPZJkjSNP+K5hHIoCRx1CRKpgV5gnz7AGWIsTLL
         ME8VZ6YE7mBVVozVqsK1SXWIJa0xUQKl1gbdiEQu/ElaD+5mQUWncpcMDktAcXXGqCJ2
         Nhxvw6tOUHen8Atu1P11Y6KYQ2s9k3XjgGhBBhtK96yut5i8Wgd2tuP44Of2lF5trOb4
         9CondWE2aU1kF/GUUho9F4UsTw5Vx8QJZoIVcrjaojNBS4C4yvjRg4hKAErhWqFOpaPH
         zN6g==
X-Received: by 10.152.3.65 with SMTP id a1mr11602876laa.40.1370293517586; Mon,
 03 Jun 2013 14:05:17 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 3 Jun 2013 14:05:17 -0700 (PDT)
In-Reply-To: <7v8v2rdnh0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226291>

On Mon, Jun 3, 2013 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> For example master..feature-a.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/related/git-related | 38 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/related/git-related b/contrib/related/git-related
>> index 3379982..20eb456 100755
>> --- a/contrib/related/git-related
>> +++ b/contrib/related/git-related
>> @@ -1,10 +1,12 @@
>>  #!/usr/bin/env ruby
>>
>>  # This script finds people that might be interested in a patch
>> -# usage: git related <files>
>> +# usage: git related <files | rev-list options>
>>
>>  $since = '5-years-ago'
>>  $min_percent = 10
>> +$files = []
>> +$rev_args = []
>>
>>  class Commit
>>
>> @@ -102,10 +104,42 @@ class Commits
>>      end
>>    end
>>
>> +  def from_rev_args(args)
>> +    source = nil
>> +    File.popen(%w[git rev-list --reverse] + args) do |p|
>> +      p.each do |e|
>> +        id = e.chomp
>> +        @main_commits[id] = true
>> +        File.popen(%w[git show -C --oneline] + [id]) do |p|
>
> Is there a solid design choice behind -C, or is it just what happens
> to have worked for you in practice?  If the former, it may want to
> be explained somewhere (either in the log or in the code) so that
> later tweaks will not break it, especially given that the invocation
> of blame seems to use double-C's.

No reason in particular.

-- 
Felipe Contreras
