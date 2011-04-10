From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
Date: Sun, 10 Apr 2011 11:36:56 +0200
Message-ID: <201104101136.58325.jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com> <1302389366-21515-11-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 11:37:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8r52-0008Am-2q
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 11:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889Ab1DJJhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 05:37:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64910 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab1DJJhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 05:37:09 -0400
Received: by fxm17 with SMTP id 17so3046750fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=mmEox9TUZGfBb4YQny4Fr4mx5XFipoVkSRs0WfYHKLI=;
        b=dkPRWxlgvXr8Nj9Mo9rF5jcFRMhkpY5lLZMdQlZnHYJHyemxidVzLbbuTw+BVi7+qV
         fBTkQZbcbmlJnj6WH8247gAMUJlwSCKltHuCdSQkHwAUvyS1vfgjaa10yNcvAxMY9Vha
         FKQe96hr351KqQHF0LZuS11RNKDv5xKVFtgYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LlMjfwrOYr4/CUhQQVYlv6Rcun+eJ2KcSXaw4HASDKAezVId33e5TsINpCXGbCnigJ
         ZG0SwbLUvHv0gJJbeF7P7DJpb98sVSQIrUdbUj+/9SPrdLUGn5ebkPMry+zBuvE1L/0Y
         ECJcuV3LAuGaY8791vma/1MeTPtVu4lR3WqBs=
Received: by 10.223.83.130 with SMTP id f2mr1825039fal.80.1302428228344;
        Sun, 10 Apr 2011 02:37:08 -0700 (PDT)
Received: from [192.168.1.13] (abwa66.neoplus.adsl.tpnet.pl [83.8.224.66])
        by mx.google.com with ESMTPS id b18sm1300574fak.8.2011.04.10.02.37.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 02:37:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1302389366-21515-11-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171244>

Jakub Narebski wrote:

> KNOWN BUGS:
> ===========
> * In 'log' view menu is generated on the right side of whole page,
>   instead of at near date, as is the case with 'summary', 'commit',
>   'commitdiff', and 'tag' views.

I'm not sure if it is behavior expected by CSS visual formatting model
or not: the issue is with absolutely positioned block element

  div.popup { position: absolute; top: 0; right: 0; }

inside relatively positioned _inline_ element

  span.marker { position: relative; }

In this case 'top: 0; right: 0' refers somehow to parent block element
of inline element... at least that's what I think.  Note that also in
the case of 'summary', 'commit', 'commitdiff' and 'tag' views the popup
position is not entirely what one could expect...

What is strange is that 'top: 0; left: 0' works correctly (sic!).
 
> * 'close-button' is not placed correctly if it uses 'float: right;'
>   style (problem floating element in absolutely positioned box, even
>   though there is no problem if containing box is has
>   position: fixed). 
> 
>   Therefore it was necessary to use absolute positioning for close
>   button.  This might cause for it to overlay 'Select timezone:' text
>   in some cases.

This is because browser didn't determine width of '.popup' block element 
at the time when float element is positioned.  Setting explicitly width 
of timezone menu will allow to use float for '.close-button'.

Both normally positioned and fixed positioned block elements have by 
default 100% width, that is why it worked for them.

Can fix in next iteration.
-- 
Jakub Narebski
Poland
