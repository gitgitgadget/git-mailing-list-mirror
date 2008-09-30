From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Tue, 30 Sep 2008 12:40:36 +0200
Message-ID: <cb7bb73a0809300340t79a497fey4ededd960223fcdd@mail.gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809300221.25094.jnareb@gmail.com>
	 <cb7bb73a0809300105s24706d79hb40e147739ec6f05@mail.gmail.com>
	 <200809301048.40046.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:42:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkcfu-0001xC-HN
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbYI3Kki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 06:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYI3Kki
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 06:40:38 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:42134 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbYI3Kkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 06:40:37 -0400
Received: by gxk9 with SMTP id 9so11573937gxk.13
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hbSeeoQy2BI541m5LwzVnEcAaNHRTbP6uZ7BjzjF+h8=;
        b=A1r0KfPXXgpr1p9V7GZXqW3q8rNuLjbT81ziytzIFM0p7yZllNK+VNmgB5HA5l83Bc
         cPfdJ5oaBQCOKMkUlUyYmWKjuyqf1Y7RdCm+JfTmWB6O1hqU0GxTrkr9f4K5hdyorg2x
         HeJCLM3lwsK0XYIZBzSB39p4S2CvFlo1kvyVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o5MqrWYGcQwZI3mgMEkaqiB9puFxIo2BTfa0q+Q7Jm/wvEjh0VZK/uiJ9bgR+3TrYc
         SJVOK5a3exgLU/gH/kDvD+07abxSq+txDZM6TaDxyKdTQqJFENQ0pTufysfd+LXxPtgu
         FJ//4uesHK1Pp7dOOnCgYvKkKxSsePJcv64ro=
Received: by 10.150.51.2 with SMTP id y2mr9701404yby.243.1222771236270;
        Tue, 30 Sep 2008 03:40:36 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Tue, 30 Sep 2008 03:40:36 -0700 (PDT)
In-Reply-To: <200809301048.40046.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97092>

On Tue, Sep 30, 2008 at 10:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 30 Sep 2008, Giuseppe Bilotta wrote:
>> On Tue, Sep 30, 2008 at 2:21 AM, Jakub Narebski <jnareb@gmail.com> wrote:

>>> I think that gitweb should use single source, not CGI query parameters
>>> or variable saving [sanitized] value.
>>
>> The alternative I've been thinking about would be to have an
>> %input_parameters hash that holds all input parameters regardless of
>> hash; thus CGI query parameters and data extracted from PATH_INFO,
>> presently, but also command line options in the future, or whatever
>> else.
>>
>> This is somewhat different from your %action_vars alternative, in the
>> sense that it isolates _input_ data, whereas if I understand correctly
>> the approach you suggest would isolate _output_ data (in the sense of
>> data to be used during link creation and whatnot).
>>
>> Presently, the gitweb code defines some $variables from the input
>> parameters, and then overwrites them for output. Keeping the input
>> stuff clearly separate from the output stuff would mean that any
>> routine can retrieve the input data regardless of the subsequent
>> mangling and without any need to make ad-hoc backups or other tricks.
>>
>> So my proposal is that I implement this %input_params stuff as the
>> first patch for the pathinfo series, and use %input_params all around
>> where cgi parameters are used currently (of course, %input_params is
>> initialized with the CGI parameters at first). The next patch would be
>> the extraction of parameters from PATH_INFO. And thirdly the PATH_INFO
>> URL generation (with or without the /-before-filename thing, at your
>> preference)
>
> I presume that you would want to replace for example $hash_base
> everywhere by %input_params{'hash_base'}?

No. %input_params{'hash_base'} would only be the _input_ hash base.
$hash_base would be kept if it's supposed to indicate the value of
hash base that is being manipulated.

> I can think of yet another solution, namely to abstract getting
> parameters from CGI query string, from path_info, and possibly in the
> future also from command line options, and use this mechanism in
> the getting parameters and validation part.
>
> The %params hash would be filled from CGI parameters by using simply
> "%params = $cgi->Vars;", then added to in evaluate_path_info instead
> of directly modifying global parameters variables.

So far I agree.

> The input validation
> and dispatch part would be modified to use %params (taking care of
> multivalued parameters as described in CGI(3pm)), like below:
>
>  our $action = $params{'a'} || $params{'action'};

Not too sure about that. The path_info (or whatever)-derived params
should be converted to use the same name as the CGI params. Or
conversely, CGI params should be mapped to the corresponding
full-form.

> That is just for consideration: each approach has its advantages and
> disadvantages.  Your proposal, as I understand it, is similar to the
> way described in "Storing options in a hash" subsection of
> Getopt::Long(3pm) manpage.

I'll read that, although it probably is.

> Or we could just scrap and revert adding href(..., -replay=>1).
> There is much trouble with getting it right and performing well,
> and it is less useful than I thought (at least now).

Dunno, the idea in itself is not bad. We just have to get it right ;)

In a way, I actually think that -replay=>1 should be the default, I
suspect it makes sense in most cases.

-- 
Giuseppe "Oblomov" Bilotta
