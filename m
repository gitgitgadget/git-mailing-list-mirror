From: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
Subject: Re: GIT, libcurl and GSS-Negotiate
Date: Mon, 5 May 2014 12:21:33 +0200
Message-ID: <CAPc4eF-aT47aEPmmPPkPRfntTNdNp=c4+OK_CPdq_7YB6rxDug@mail.gmail.com>
References: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
	<20140426174718.GC238861@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 18:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhxG-0005Yp-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158AbaEEKVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 06:21:35 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:54492 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764AbaEEKVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 06:21:34 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so1165596oag.25
        for <git@vger.kernel.org>; Mon, 05 May 2014 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=JSMfnOE6kiM5vFD5hNz7IJF+lKgD4bMKs+qXRSsE/kg=;
        b=Csk9RzrS6NnD2NOhEjaOoPDSK312/+Ybzf77A2bc8EDEF1B/0nHlq1W52bLkU7Md2g
         uARvuQC1Uy1+/gpLRhVbBjIzBEYaAOhdgnoI4hq4VP/5urSjUH8qCSXXhDZoFlMnFwOX
         cmTdVL9/Xbil09mi+3oWQkYkiBQFVaNzLRyWM7amGRwWDXhgmWzjIm21snwJTPDPIpo0
         wy8afrBNzwwj4y28rt3GdiGbIzvEUuGO2Y9/ushgVxsEZFBQrvY5qYNDpMd46OehRsb8
         3YzkeDd7HG3SUjeILvHU1mt6Lj8t3/D/6Kk0k1sy4OflDB3Moeq6JBaiD8whPCfXfwT8
         79jg==
X-Received: by 10.182.2.72 with SMTP id 8mr30910767obs.21.1399285293733; Mon,
 05 May 2014 03:21:33 -0700 (PDT)
Received: by 10.76.150.137 with HTTP; Mon, 5 May 2014 03:21:33 -0700 (PDT)
In-Reply-To: <20140426174718.GC238861@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248149>

Well, I'm on Windows.
using `git version 1.9.2.msysgit.0`.

You can find all the exchanges, recorded with wireshark, of the
following usecases:
* git vanilla (not working),
* VisualStudio2013 with libgit (working)
* curl (--ntlm, working)
* curl (--negotiate, not working)

They're available on
[github](https://github.com/nilleb/my-documents/tree/master/msysgit%23git%2C%20issue-171).



On Sat, Apr 26, 2014 at 7:47 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Apr 24, 2014 at 07:17:36PM +0200, Ivo Bellin Salarin wrote:
>> To shortly resume it, the problem is that:
>> * when the authentication method (WWW-Authenticate) is Negotiate AND
>> * when the server proposes a NTLMSSP_CHALLENGE in response of the
>> client's NTLMSSP_NEGOTIATE,
>> => libcurl yields an "Authentication problem. Ignoring this.\n"
>> And the communication is closed.
>>
>> At this point, in a normal communication, the client should send a
>> NTLMSSP_AUTH containing a Kerberos ticket.
>>
>> Having seen the libcurl source code, I think we're passing through the
>> lines  from 776 to 780 of
>> [http.c](https://github.com/bagder/curl/blob/2e57c7e0fcfb9214b2a9dfa8b3da258ded013b8a/lib/http.c).
>> Some guy, on the github issue page, has suggested that this could be
>> related to an update of libcurl, when git was at its 1.8.2 version.
>>
>> I'm not debugging libcurl, and I can't reproduce this problem @home.
>> So, has somebody already experienced the same problem? Is there a
>> solution?
>
> I'm personally using Git with GSS-Negotiate (and MIT Kerberos 5) and it
> does seem to work correctly for me.  For large pushes, your server (and
> any intermediate proxies) will need to support 100 Continue properly, as
> there's simply no other way to make it work.
>
> What version of curl are you using (and what distro if you didn't
> compile it yourself)?  Also, can you post output of an attempt to push
> with GIT_CURL_VERBOSE=1?
>
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187



-- 
http://www.nilleb.com
