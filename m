From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 10:57:06 +0000
Message-ID: <200702201057.21398.andyparkins@gmail.com>
References: <200702191839.05784.andyparkins@gmail.com> <200702201021.58754.andyparkins@gmail.com> <7vabz9w270.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 11:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJSgg-0006al-2L
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 11:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbXBTK5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 05:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932870AbXBTK5a
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 05:57:30 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:54336 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732AbXBTK5a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 05:57:30 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1919384nze
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 02:57:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RVVBvBOaAiRK6POO0Px+uHgoVBhY8P5Lz6UXx44SsTY7nvjCUEZNvlghF99KhDb1TBLDKz0bQnLr3C5lmkHFED4MdF39Re3C3pi+YrfYuQdOl52pwzraxEUlHtP47bb6lGPtrjn++UjEEIutuLyBCXIJ+kXK/BkWM2uQ/xwD96U=
Received: by 10.64.185.7 with SMTP id i7mr11516544qbf.1171969049247;
        Tue, 20 Feb 2007 02:57:29 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id l21sm20734243nfc.2007.02.20.02.57.26;
        Tue, 20 Feb 2007 02:57:26 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vabz9w270.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40230>

On Tuesday 2007 February 20 10:30, Junio C Hamano wrote:

> If we _were_ doing the inline function, I would actually prefer:
>
>         static inline ref_is_head(const char *ref)
>         {
> 		return !prefixcmp(ref, PATH_REFS_HEADS);
>         }

As you brought it up...

I've never really liked "!" on strcmp() lines (but I accept that that is the 
tradition in git) because it implies the the output of prefixcmp is boolean, 
but it's actually ternary.  strcmp() (I think), should be thought of as 
outputting

enum {
 STRING1_LESS_THAN_STRING2,
 STRINGS_EQUAL,
 STRING1_GREATER_THAN_STRING2
}

Given that, it makes me uncomfortable to use !strcmp().  Of course in the case 
of strcmp(), that form is so well known that it makes very little difference 
to the reader.

I have similar feelings about

 if( !something )

being incorrect when you meant

 if( something == NULL )

While they are identical in what they generate, they send a different message 
to someone reading the code.

Regardless, I'm not so stubborn as to refuse to go with the flow...

> But at least to me,
>
> 	if (!prefixcmp(head, PATH_REFS_HEADS))
> 		head += strlen(PATH_REFS_HEADS);
>
> is easier to follow than:
>
>         if (ref_is_head(head))
>                 head += STRLEN_PATH_REFS_HEADS;

Fine.  I don't really mind - and it's less work on my patch :-)

My argument in favour of the ref_is_head() method is that the prefixcmp() 
method requires knowledge from the caller about how you tell whether a given 
ref is a head - the second pushes that information further down the call 
tree, abstracting it out just a little more.

As I say though - it's not a problem for me.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
