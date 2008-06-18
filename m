From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Wed, 18 Jun 2008 03:25:20 +0200
Message-ID: <48586400.4000504@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <200806180054.33490.jnareb@gmail.com> <48584D1F.5070000@gmail.com> <200806180212.15392.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 03:26:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8mRq-0005D6-58
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 03:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837AbYFRBZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 21:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758314AbYFRBZY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 21:25:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:50166 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbYFRBZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 21:25:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so12209fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=83TauJCLeKqbUZ2dWRUbGnFdEj3TaMYdZHi/whyVZF8=;
        b=DTt7DGmVz8MHLIfoe5VIyNGE7nkDqZT27A9q8SYvRpPr9Ssjv3TYSMlZPM+rDW+KOW
         owlqIJAoOJW45arIUA77a+X40lkr7FExwyDGXSpgPHH2U8hj4bhcqB3rjHmyaNxRXnQx
         zDVQZUHrkIXGizDTZPTfx4SyNv9/FOP/Mq6SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=flABpgO0fJ2IFEFuM5W+gnGI43IvN16VzRraGNldkNG3d0fv/aU10mr79kzwVtMZXf
         VSF6PdbS3TN/DcNGSD9SRPZvpJW+AsaWo7U087y6V/hj0DFvB074kC1OzoHlZOgDdCqy
         bU/JTnuGtVtVlq+7UWh11vQkR0XTzzBtGcz2c=
Received: by 10.86.68.20 with SMTP id q20mr40286fga.2.1213752320855;
        Tue, 17 Jun 2008 18:25:20 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.48])
        by mx.google.com with ESMTPS id l19sm14200241fgb.7.2008.06.17.18.25.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 18:25:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806180212.15392.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85351>

Jakub Narebski wrote:
> Lea Wiemann wrote:
>> $hash = get_hash($symbol, 'commit'); # 'commit' to resolve tags
> 
> Errr... is there equivalent to ^{}, i.e. resolve to non-tag?

Yup.  Haven't quite decided whether to simply use "$symbol^{type}" or 
make type a separate parameter.

> Note that you would have to examine gitweb sources to check if it
> uses href(..., -replay=>1) when it should,

Good point, will do.

> BTW. one of earliest idea was to fully resolve hashes, add missing
> parameters if possible (like 'h', 'hp', 'f') and convert hashes to
> sha-1.  One of intended uses was (weak) ETag for simple HTTP caching.

Interesting.  Something to keep in mind is that using name-rev still can 
wreck with this since it has the unique property of taking hashes but 
still depending on the current refs.  Gitweb isn't using name-rev a lot 
right now, but that might change of course (e.g. I think that it would 
be convenient to always display names along with any commit hashes).

> All the time I think that caching _everything_ is a bad solution.

So?  We can easily add an option to the cache; e.g. no_cache => 
['get_blob', 'ls_tree'].  I doubt that it will be needed, but if it 
does, it's easy to add it.  Don't worry about it, really.

> CHI (or other in recommended thread) for inobtrusive data caching

Thanks for the pointer!  On the one hand CHI is very recent and not even 
in Debian, on the other hand it provides things like busy_lock on top of 
Memcached (AFAICS), at fairly little cost.  I'll look into it.

-- Lea
