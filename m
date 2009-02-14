From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: fix wrong base URL when non-root DirectoryIndex
Date: Sat, 14 Feb 2009 09:52:56 +0100
Message-ID: <cb7bb73a0902140052h15fa60bfs8a0becab84c997c1@mail.gmail.com>
References: <200902122303.37499.jnareb@gmail.com>
	 <200902130945.20601.jnareb@gmail.com>
	 <7vskmh3gtv.fsf@gitster.siamese.dyndns.org>
	 <200902140342.26270.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 09:54:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYGIA-0008CJ-Vh
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 09:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbZBNIxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 03:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbZBNIw7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 03:52:59 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:32999 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbZBNIw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 03:52:59 -0500
Received: by ey-out-2122.google.com with SMTP id 25so186961eya.37
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 00:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FclfOO352KrY8dFQfMZKd1WiXzyL9B/5AEUgJXBvKtQ=;
        b=ZYyvUSIcpaEWLxCBeCkJ51Tgp3Rsle8a/4wUV+AkU4ucEMAEG+mQw5d1UN/f4cv0kK
         53FVse1WaDyLSczjsURUONk0qtxdRlim9xVdpnsAUTJTJ1aSPHfWQtHL2zd1ypXCkqvv
         HX10HWZPu2s/1alYtexx0rKV25D7Nnkqa2jJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qlFIGomD8R7ImPzrmyL77JP2itEa4GKWzh9b8vTGt7GJZlvPBlA+u2gdlQ88VUi5fn
         6+BuKMxRn1RTU5FWE8fojJOJxbmohWQiGEpSvziFkYfUKt2qTJXNRRughi31cHAue25Y
         6S99FopX8jLQWZStNTQ48NOosjjazDmZ7BqIU=
Received: by 10.210.137.14 with SMTP id k14mr2365719ebd.175.1234601576580; 
	Sat, 14 Feb 2009 00:52:56 -0800 (PST)
In-Reply-To: <200902140342.26270.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109845>

On Sat, Feb 14, 2009 at 3:42 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 14 Feb 2009, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>>>
>>> Sounds good. I don't use gitweb as DirectoryIndex myself, but
>>> Acked-by: Jakub Narebski <jnareb@gmail.com>
>>>
>>>> +# Another issue with the script being the DirectoryIndex is that the resulting
>>>> +# $my_url data is not the full script URL: this is good, because we want
>>>> +# generated links to keep implying the script name if it wasn't explicitly
>>>> +# indicated in the URL we're handling, but it means that $my_url cannot be used
>>>> +# as base URL. Therefore, we have to build the base URL ourselves:
>>>> +our $base_url = $cgi->url(-base => 1) . $ENV{'SCRIPT_NAME'};
>>
>> Breaks t9500 with
>>
>>     [Sat Feb 14 02:12:59 2009] gitweb.perl: Use of uninitialized value in
>>     concatenation (.) or string at /pub/git/t/../gitweb/gitweb.perl line 45.
>>
>> Please be more careful when giving an Ack, and more importantly please do
>> not send a patch that does not even pass the test suite by itself.

Sorry, my fault. For future reference for myself, is there a way to
only run the gitweb tests of the testsuite?

> Actually this is not a bug in _gitweb_, but in _test_ itself.
>
> In t/t9500-gitweb-standalone-no-errors.sh we run gitweb.perl as
> a standalone script (not from a web server), and we set _some_ of CGI
> environmental variables.  Up till now we could get by using only most
> important ones: GATEWAY_INTERFACE (I'm not sure if needed), HTTP_ACCEPT
> (used to select Content-Type to use), REQUEST_METHOD (git_feed exits
> early on HEAD request), and of course QUERY_STRING and PATH_INFO.
> The required variable SCRIPT_NAME is simply not set...

Thank you for the additional patch. One thing we should also probably
add to the test is the HTTP_IF_MODIFIED_SINCE. I will try to think of
a bunch of tests to run against feed production after I implement the
reflog data check.

-- 
Giuseppe "Oblomov" Bilotta
