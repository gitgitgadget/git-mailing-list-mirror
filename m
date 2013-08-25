From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sat, 24 Aug 2013 21:23:14 -0700
Message-ID: <20130825042314.GE2882@elie.Belkin>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
 <xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 06:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRrH-0000VS-R9
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 06:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab3HYEXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 00:23:20 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:36095 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab3HYEXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 00:23:19 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so2172514pbc.29
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 21:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G/I2kyj2CHBBr8/LoGqtvZrN1gRY6U0+SOGd3+aF+lM=;
        b=mTCUn6/0/eHfl5iW+NKbx2Eb2AC+EOLjdSwsiUnwO6do+GsHgD/tv8EJL+9OQfdJyN
         5TIs/w9HD+5Ygw7Andh3jz9X/SLHs6i8YsZaX6YZhp15CPUcoDBoPdzGWxO9YOf6Hw1p
         lAQEMe48VRIytXUmCSfb3KQSoA+FlQYP2QG0JFKw6XRfbMgJAbxCZoHH7wzZKy04soxS
         CwlDsSF/cyIPT+30gm8wVcnFpAQ3qYswvff8YT1ttxWHUMpBptOnP9xpFKK06wKeDRIS
         RoRQa5lFQ2QrenonEQjX/vrVJsJLgsI9cUoNfwMzjPBnUYsKoyOK8uqZREX7pGpuO4eS
         cj0Q==
X-Received: by 10.66.139.166 with SMTP id qz6mr7490950pab.88.1377404599224;
        Sat, 24 Aug 2013 21:23:19 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id wr9sm9561197pbc.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 21:23:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232912>

Junio C Hamano wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>> On Sat, Aug 24, 2013 at 9:35 PM, Phil Hord <hordp@cisco.com> wrote:

>>> When the pathspec given to grep includes a tree name, the full
>>> name of matched files is assembled using colon as a separator.
>>> If the pathspec includes a tree name, it should use a slash
>>> instead.
[...]
>>   If the tree name includes an object name, as in
>>   HEAD:some/path, it should use a slash instead.
>
> What problem are you trying to solve?  It should use HEAD:some/path,
> not HEAD/some/path.

I think Phil meant that when "git grep" is asked to search within
"HEAD:some/path", filenames tacked on at the end should be appended
with a '/' separator instead of the usual ':' (e.g.,
"HEAD:some/path/inner/path.c", not "HEAD:some/path:inner/path.c").
Otherwise I cannot copy and paste "git grep" output and get something
suitable for passing to "git show".

I don't think we have a standard name for the tree:path syntax.  I've
always just called it tree:path syntax. :)

Hope that helps,
Jonathan
