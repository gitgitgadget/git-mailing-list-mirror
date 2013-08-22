From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCHv6 1/2] repack: rewrite the shell script in C
Date: Thu, 22 Aug 2013 12:46:19 +0200
Message-ID: <5215EBFB.1060402@kdbg.org>
References: <5214F816.3010303@googlemail.com> <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com> <xmqqfvu2u5io.fsf@gitster.dls.corp.google.com> <52153C01.6040101@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	mackyle@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 12:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCSWv-0000Zb-3t
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 12:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab3HVKyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 06:54:13 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:15850 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752503Ab3HVKyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 06:54:12 -0400
Received: from [10.75.26.165] (178.115.250.165.wireless.dyn.drei.com [178.115.250.165])
	by bsmtp.bon.at (Postfix) with ESMTP id 1EEA7CDF93;
	Thu, 22 Aug 2013 12:54:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <52153C01.6040101@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232762>

Am 22.08.2013 00:15, schrieb Stefan Beller:
> On 08/21/2013 10:56 PM, Junio C Hamano wrote:
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>> +static int delta_base_offset = 1;
>>> +char *packdir;
>>
>> Does this have to be global?
>
> As the path is pretty obvious (get_object_directory() + "/pack"),
> we could however also construct it again in the signal handler.

I would advise against doing that. The recomputation would call malloc(), 
which is not async-signal-safe. (It would not be the first case where we 
call "forbidden" functions from signal handlers, but we need not pile more 
on top of them.)

-- Hannes
