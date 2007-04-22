From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver 
  definition.
Date: Sun, 22 Apr 2007 02:09:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz>
References: <11771520591529-git-send-email-junkio@cox.net><11771520591703-gi
 t-send-email-junkio@cox.net><Pine.LNX.4.63.0704211821560.5655@qynat.qvtvafv
 gr.pbz> <7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 11:43:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfYbM-0001y0-0F
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 11:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbXDVJnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 05:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbXDVJnT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 05:43:19 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:48625 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754052AbXDVJnS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 05:43:18 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 22 Apr 2007 02:43:18 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 22 Apr 2007 02:43:14 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45231>

On Sat, 21 Apr 2007, Junio C Hamano wrote:

> David Lang <david.lang@digitalinsight.com> writes:
>
>> 1. it would be useful in many cases for the filter program to know
>> what file it's working on (and probably some other things), so there
>> are probably some command-line arguments that should be able to be
>> passed to the filter.
>
> I can see that you missed the class when Linus talked about how
> messy things would get once you allow the conversion to be
> stateful.  I was in the class and remembered it ;-)
>
> Although I initially considered interpolating "%P" with
> pathname, I ended up deciding against it, to discourage people
> from abusing the filter for stateful conversion that changes the
> results depending on time, pathname, commit, branch and stuff.

I didn't miss it, I just don't think that the path in the repository is 
nessasarily as dangerous as the other things (time, branch, etc)

one thing that was listed as a possibilty was to use the sha1 of the file, but 
you would force the filter to calculate that itself. it's already available when 
extracting and recalcuating it is a waste

>> 2. should this be done as a modification of the in-memory buffer (s
>> this patch does it?) or should it be done at the time of the
>> read/write, makeing the filter be responsible for actually doing the
>> disk I/O, which would give it the benifit of being able to do things
>> like set permissions and other things ...
>
> The conversion is not about overriding the mode bits recorded in
> tree objects, nor making git as a replacement for build procedure.

what build procedures?

I'm talking about doing things like managing files in /etc

git doesn't have all the hooks to be able to set the permissions when you 
extract a file, but if the filters were actual readers/writers instead of 
in-memory operators, this becomes trivial to implement with no further changes 
to git itself

>> 3. why specify seperate clean/smudge programs instead of just one
>> script with a read/write parameter?
>
> I think the most common two ways have clean as a cleaner and
> smudge as a no-op (similar to crlf=input conversion), or clean
> and smudge are inverse operations (similar to crlf=true
> conversion.  I do not see a sane case where clean and smudge are
> the same, unless you are thinking about the toy demonstration
> test piece I added to t0021 which uses rot13 as both clean and
> smudge filters.

actually, I'm thinking of much more complicated filters, where it's easier to 
have one program do both functions then it is to have two seperate programs 
(like tar -c /tar -x)

David Lang
