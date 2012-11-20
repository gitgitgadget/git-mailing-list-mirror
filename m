From: Andreas Ericsson <ae@op5.se>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 12:08:04 +0100
Message-ID: <50AB6494.3070109@op5.se>
References: <20121119095747.GA13552@arwen.pp.htv.fi> <20121119151845.GA29678@shrek.podlesie.net> <7vk3thxuj2.fsf@alter.siamese.dyndns.org> <20121119225838.GA23412@shrek.podlesie.net> <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com> <7vlidxuowf.fsf@alter.siamese.dyndns.org> <20121120073100.GB7206@shrek.podlesie.net> <20121120075628.GA7159@shrek.podlesie.net> <CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Talgo-0000Hc-1o
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 12:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab2KTLIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 06:08:10 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:39832 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab2KTLIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 06:08:09 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1837055lag.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 03:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=t6nexDPZWqDAr2TufY8Z/R3QTgq4CBYKFloFYErPkbI=;
        b=Puawu0XvAIhcRE98wRzVdOWzgq5HxWZ3RYxW+eNc+uLG7OtioKc2PTq2DCT+5VMj1E
         FHWRu4wDloBObLEJi9ypovTS4p3674CI6UDZmjGM4ijZ7FL52up0nrleKo81myNqdJnE
         7/oI1fsRzP4HICoVVpjjinLeGO4zfTHKC5eVNMDqry0YyhoS1QeSwF4Xiv88L5Po8tMu
         BDjXLzTQrOxb/Ja6OIf/XMMuAq1UVvxxIEBAsIpv8q6oO9lFNvtnOB7x/vyS3Crw4at5
         KPddZ7EiUITxRwTnyKnYyVj9j4hDQDt7Wme/Zt03H08HYj8LgYKdsAlebXUNVWqLHGND
         lUmA==
Received: by 10.112.9.199 with SMTP id c7mr6250714lbb.70.1353409687436;
        Tue, 20 Nov 2012 03:08:07 -0800 (PST)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id pw17sm4645154lab.5.2012.11.20.03.08.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Nov 2012 03:08:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
In-Reply-To: <CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQlZMQt0GcJZjtMZyabGM3tHChnqAT55Pb1ckT7TyjthaYim7Wxo5SviVcYnM+0tj+u2YRf/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210090>

On 11/20/2012 11:28 AM, Felipe Contreras wrote:
> On Tue, Nov 20, 2012 at 8:56 AM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
> 
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -925,8 +925,11 @@ sub quote_subject {
>>   sub sanitize_address {
>>          my ($recipient) = @_;
>>
>> +       my $local_part_regexp = qr/[^<>"\s@]+/;
>> +       my $domain_regexp = qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
>> +
>>          # remove garbage after email address
>> -       $recipient =~ s/(.*>).*$/$1/;
>> +       $recipient =~ s/^(.*?<$local_part_regexp\@$domain_regexp>).*/$1/;
> 
> I don't think all that extra complexity is warranted, to me
> s/(.*?>)(.*)$/$1/ is just fine.
> 

It's intentionally left without the at-sign so one can send mail to a
local account as well as remote ones. Very nifty when debugging, and
when one wants to preview outgoing emails.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
