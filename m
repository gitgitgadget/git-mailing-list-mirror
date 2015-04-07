From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: EOL conversion on checkout for text files only
Date: Tue, 07 Apr 2015 10:47:56 +0200
Message-ID: <552399BC.5030401@web.de>
References: <CAHNoia06Q-jsskQn6TBkT8zPY7m14qmEL70HBm18CA-SaMrWtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Borek Bernard <borekb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 10:48:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfPB2-0001vr-Cr
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 10:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbbDGIsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 04:48:05 -0400
Received: from mout.web.de ([212.227.15.4]:65211 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbbDGIsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 04:48:01 -0400
Received: from [192.168.2.107] ([79.223.100.247]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MbyJ4-1Yxd513UWc-00JM9j; Tue, 07 Apr 2015 10:47:58
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAHNoia06Q-jsskQn6TBkT8zPY7m14qmEL70HBm18CA-SaMrWtg@mail.gmail.com>
X-Provags-ID: V03:K0:1rEJY2/NdlXDCtb9+yBib7PZV5hKwIKjoR2p/5KtNTVp64voyjy
 0X8rLw1iafpw3EfVIcTrCsy/ZHzw41REr95so5YCuV/eP2Upbb5Xt27cNOhP0HxCbIpzmga
 1SXyIqJkskypUYxfJLbWdI5tA9mtmINXBI6sLDzhWjwiPSUvclavj1zFo9Z5ro3FR0weiF6
 qSHb3lQLrdB6sgkGdHP9Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266905>

On 2015-04-06 20.05, Borek Bernard wrote:
> Hi,
> 
> I'd like to propose a new behavior around EOL normalization / forcing
> using gitattributes.
> 
> My use case is this: I want to ensure that LF line endings are used in
> the repo *and* in all working directories, on all platforms (in our
> case, the text files MUST be LF even on Windows).
> 
> The first part is easy to achieve using this in a .gitattributes file:
> 
>     * text=auto
> 
> This will correctly normalize *text files* in the repo. However, the
> second part (LF forcing on checkout) cannot be achieved easily today
> because adding `eol=lf` will unfortunately process binary files too.
> The only solution today is to mark certain types for conversion (e.g.,
> `*.txt eol=lf`) or, inversely, mark certain types as binary (e.g.,
> `*.png binary`).
> 
> Both of these suffer from the same issue: the specific file types must
> be listed explicitly in the .gitattributes file, which means that
> either the types must be known ahead of time or all developers must
> remember to update the .gitattributes file every time a new file type
> appears in the project. Which they won't.
> 
> The simplest solution in my eyes would be just to change the behavior of
> 
>     * text=auto eol=lf
> 
> to do both the checkin and checkout EOL conversions on *text files
> only*, using the same text/binary detection algorithm that is already
> in place for the checkin direction. This feels the most intuitive to
> me and I think it would not be a breaking change.
> 
> Related IRC discussion:
> http://colabti.org/irclogger/irclogger_log/git?date=2015-04-04#l1143
> 
> Thoughts?
> 
> Thanks,
> Borek

I think the suggestion makes sense.

I could find 2 things that needs to be improved:

- (1) Specifying "eol=lf" currently overwrites text=auto, this is in convert.c

- (2) The .gitattributes file should overrule core.autocrlf.
      This is what the documentation says, but the code doesn't work like that.
      See convert.c, output_eol()

- (3) we don't have test cases.

I can probably contribute with 3) and may be 1), but the major work is to improve (or re-factor)
the code in convert.c



 
