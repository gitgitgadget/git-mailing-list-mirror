From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: Re: [PATCH v2] Allow HTTP user agent string to be modified.
Date: Sat, 07 Aug 2010 21:57:35 -0600
Message-ID: <1281239855.7520.3.camel@compaq.olson.home>
References: <1281152060-16736-1-git-send-email-olsonse@umich.edu>
	 <AANLkTi=G=GvxXEh1hGuYQK42cdkMUaFhqxsQ39K=2180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 05:58:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohx1J-00067u-9t
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 05:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290Ab0HHD5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 23:57:41 -0400
Received: from smtp.mail.umich.edu ([141.211.14.81]:52743 "EHLO
	hackers.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab0HHD5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 23:57:40 -0400
X-Greylist: delayed 37554 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Aug 2010 23:57:40 EDT
Received: FROM [192.168.1.5] (174-28-223-52.albq.qwest.net [174.28.223.52])
	By hackers.mr.itd.umich.edu ID 4C5E2B32.7887.1328 ;
	Authuser olsonse;
	 7 Aug 2010 23:57:38 EDT
In-Reply-To: <AANLkTi=G=GvxXEh1hGuYQK42cdkMUaFhqxsQ39K=2180@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152882>

On Sun, 2010-08-08 at 10:51 +0800, Tay Ray Chuan wrote:

> >  static char *user_name, *user_pass;
> > +static const char *user_agent = NULL;
> 
> This can be skipped, I think.

My only reason for wanting to initialize is because I don't trust all
compilers to follow the standard.  But, since there are so many other
instances of relying on the compiler to zero out static vars in other
places already, I don't have any problem with conforming...


> 
> >[snip]
> > @@ -279,7 +283,10 @@ static CURL *get_curl_handle(void)
> >        if (getenv("GIT_CURL_VERBOSE"))
> >                curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
> >
> > -       curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
> > +       if (user_agent != NULL)
> > +               curl_easy_setopt(result, CURLOPT_USERAGENT, user_agent);
> > +       else
> > +               curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
> 
> Hmm, perhaps
> 
>     curl_easy_setopt(result, CURLOPT_USERAGENT,
>         user_agent ? user_agent : GIT_USER_AGENT);
> 
> to replace the if-else?

That is perfectly fine with me.
