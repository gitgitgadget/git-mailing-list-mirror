From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 2/2] test-lib.sh: fix color support when tput needs ~/.terminfo
Date: Wed, 17 Jun 2015 15:55:05 -0400
Message-ID: <5581D099.7090200@bbn.com>
References: <1434567986-23552-1-git-send-email-rhansen@bbn.com> <1434567986-23552-3-git-send-email-rhansen@bbn.com> <20150617194315.GE25304@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:55:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JQX-0006hr-4V
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbbFQTzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:55:08 -0400
Received: from smtp.bbn.com ([128.33.0.80]:64637 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbbFQTzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:55:07 -0400
Received: from socket.bbn.com ([192.1.120.102]:34544)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Z5JQP-00036n-V0; Wed, 17 Jun 2015 15:55:06 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id AB087401D5
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150617194315.GE25304@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271899>

On 2015-06-17 15:43, Jeff King wrote:
> On Wed, Jun 17, 2015 at 03:06:26PM -0400, Richard Hansen wrote:
>> +	say_color_error=$(tput bold; tput setaf 1) # bold red
>> +	say_color_skip=$(tput setaf 4) # blue
>> +	say_color_warn=$(tput setaf 3) # brown/yellow
>> +	say_color_pass=$(tput setaf 2) # green
>> +	say_color_info=$(tput setaf 6) # cyan
>> +	say_color_sgr0=$(tput sgr0)
>> [...]
>> +		error|skip|warn|pass|info)
>> +			eval "say_color_color=\$say_color_$1";;
>>  		*)
>>  			test -n "$quiet" && return;;
> 
> I think you could dispense with this case statement entirely and do:
> 
>   eval "say_color_color=\$say_color_$1"
>   if test -z "$say_color_color"; then
>           test -n "$quiet" && return
>   fi
> 
> I guess that is making the assumption that all colors have non-zero
> sizes, but that seems reasonable.

We could test if the variable is set first (test -n "${foo+set}"), at
the cost of a bit more complexity.

> I do not mind it so much as you have
> it, but it does mean adding a new field needs to update two spots.

I also don't like the duplicate list of color types, and I considered
doing something similar to what you suggested, but I decided against it.
 I'm a bit worried about bizarre syntax errors or code execution if
say_color() is used improperly.  ('eval' with uncontrolled variables
makes me nervous.)

Thanks for reviewing,
Richard
