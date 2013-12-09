From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Mon, 9 Dec 2013 11:12:24 -0800
Message-ID: <20131209191224.GR29959@google.com>
References: <20131206211222.GB20482@sigill.intra.peff.net>
 <20131206211509.GB20536@sigill.intra.peff.net>
 <20131206220520.GA30652@sigill.intra.peff.net>
 <xmqqmwk9zvyy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:12:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq6Ft-0006qJ-4G
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760429Ab3LITM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 14:12:29 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:51888 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab3LITM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 14:12:28 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so2998623yha.23
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GAj86v6qWmCUIrr1Y2aRUYSD2RWG1Az0vjmo5YwPJXQ=;
        b=i0AjTbQRMTyvmL71mtbAFHQUyRY+npe20tKzY3gFInNktVBhGIiIhr35MuA5zY5n2H
         nPrvD3ox17hQSwEK5UWFwysIQ8KWTmT1vJWA/7YJ7hiadEx59YkQ1r6d5k3fhgslZ7W/
         31uWgOPhZax2YblcfIrMutQ5p5ould0eYa5feD7rZNHCwA/JzBj7X9BuEPqMYfkvjguo
         hL91AgfgpSHlS1P96uWn13Ryujs9WkNrOV9nDLImb3TfEyY+dggMG8LSAIh+Q3rr+O3A
         wiwdNKjFI6oGR7AwQMa42EchYfu7Qi0qw+rz78ZAw62ajjlfW2IO5aC3pxk/bCdk1Ra7
         otiA==
X-Received: by 10.236.223.168 with SMTP id v38mr4188891yhp.86.1386616347904;
        Mon, 09 Dec 2013 11:12:27 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id q44sm18001512yhg.10.2013.12.09.11.12.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 11:12:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqmwk9zvyy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239078>

Junio C Hamano wrote:

>>                                      So maybe we are doing a favor by
>> calling out the problem; if they want a rev, they should be using
>> "--verify" (or "--").
>
> I tend to agree with the reasoning in the last sentence. Let's cook
> it for a while and see what happens.

Isn't this essentially breaking a contract that would have been relied
on by any script that used "git rev-parse HEAD~3..HEAD"?  Worse, it's
breaking that contract in a way that no one would notice until they
are asked to manipulate a worktree with a file named 'HEAD~3..HEAD'
--- in other words, the breakage it introduces is painfully subtle.

I agree that "git rev-parse HEAD" is better written as "git rev-parse
--verify HEAD" and hence not so much worth worrying about, but I don't
find it easy to believe that people should have anticipated this
change and added a trailing "--" to more complex rev-parse
expressions.

So to be clear, I think unless it is protected by a new option, this
is a bad idea.

Hope that helps,
Jonathan
