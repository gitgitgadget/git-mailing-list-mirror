From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Wed, 04 Sep 2013 15:59:03 -0400
Message-ID: <52279107.2070205@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com> <ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com> <xmqqsixkmonq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:01:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHJGP-0003Tl-9q
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759550Ab3IDUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:01:12 -0400
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:57503 "HELO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757078Ab3IDUBL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Sep 2013 16:01:11 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]) (using TLSv1) by na3sys009aob124.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUieRhWVi/6jXDFMZS3qMNqB929Ahr7+H@postini.com; Wed, 04 Sep 2013 13:01:11 PDT
Received: by mail-ob0-f182.google.com with SMTP id wo10so964855obc.27
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 13:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4oekCXFsPqgDHAtoUAv1ibqHIoz77xZllBOMEBGKWns=;
        b=j1eXMbXUSIRoJiGr8x0ennsdZZfMjZ6oxP5mxK2DnNcXXDy1eO5/xcIvQqcXfdZQm5
         Mb+9Jf3X6m4LHh5XsytqIF47PX57DvzIPtn3gzBwt6BIDZo0mwBFH9Q6VtM469gbQEUg
         lhwPGA+8QDwGj46eBipnEADQOuCTirmCFt/ZtUNL0nSBKTflid8PpdrSVx/sFaLwJtz9
         SNryc/cSJBJdXvFYemQNAxxWZ6qFo01MxBAX2Ia8JLAELdSmTrA47tjbmGfsbmfZR+Ic
         E1F0WYWsObFq4b1sEEWw9DxAAtgeo1meJIKDzzyN/HN2a9i0rV8jJ3Tw9bW2JYbM50nH
         GM7g==
X-Gm-Message-State: ALoCoQmQmCdjTpTDScm1xWePwV4V6gASQftsPCBXxdfeEhQkhpe1rS/l8EggFEZEDfYfwcVnbjeZ471wiun3D2Jorg4qzx5fR6z+YnrTn0zcQLxhHvIUOw4/OfSVtoZY2hyxKKIGN5nE6xLMsk+Y2Qr0x8Z4FrbtmA==
X-Received: by 10.182.119.229 with SMTP id kx5mr3514786obb.23.1378324859453;
        Wed, 04 Sep 2013 13:00:59 -0700 (PDT)
X-Received: by 10.182.119.229 with SMTP id kx5mr3514641obb.23.1378324857336;
        Wed, 04 Sep 2013 13:00:57 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id xr8sm25510169obc.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 13:00:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqsixkmonq.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233868>

On 09/04/2013 02:23 PM, Junio C Hamano wrote:
> "whitespace-separated" implies that we may allow fields separated with not a single SP, but with double SPs or even HTs between them. I personally do not think we should be so loose

Okay, I will look at making it more strict.  See proposed format
below.

>> +Quote arguments containing whitespace as if in C source code.
> 
> Probably "as if they were strings in C source code".

Fixed.

>> +terminate each argument by NUL and each line by LF NUL.
> 
> This is a somewhat interesting choice of the record terminator. Do we have a precedent to use LF NUL elsewhere?  If this is the first such case where we need to express variable number of NUL-separated fields in a record, I think I am fine with LF NUL (but I am sure other people would give us a
> better convention if we ask them politely ;-)), but I just want to make sure we do it the same way as other codepaths, if exist, that have to handle this kind of thing.

Nothing else uses LF NUL.  I chose it as a starting point for
this very discussion, which I asked about in $gmane/233653.
In this particular use case we know the last field will never
be LF but that may not be so for future cases.  There is no way
to represent sentinel-terminated arbitrary variable-width records
of NUL-terminated fields without some kind of escaping for the
sentinel value, but the whole point of -z is to avoid escaping.

Below is a survey of all mentions of NUL and \0 in documented
formats as of v1.8.4.  The summary is that most are fixed-width
records but a few have variable width allowing n or n+1 fields.
In all variable-width cases there is structured information in
the first field that indicates the number of NUL-terminated
fields to expect.

In the motivating case here, we could use a --no-old or
--have-old option to indicate in one field how many more to
expect in the record, but that will be quite verbose.

Side note: I'd like to reserve room for the leading options to
include things like "-m NUL <reason> NUL" so we cannot keep them
all in in a single NUL-terminated, SP-separated field.

Another approach is to introduce a way to represent "not here"
for the <oldvalue> argument that is not an otherwise valid value.
This would make the non-option part of the record have a fixed
width of 3 fields.  For example, we could use SP in -z mode:

 [-<opt> NUL]... <ref> NUL <new> NUL (<old>|SP) NUL

and the last field can be optional in non-z mode anyway:

 [-<opt> SP]... <ref> SP <new> [SP <old>] LF

Or we could use a character like "~" (other ideas?):

 [-<opt> NUL]... <ref> NUL <new> NUL (<old>|~) NUL

and make it available in non-z mode too:

 [-<opt> SP]... <ref> SP <new> [SP (<old>|~)] LF

Thoughts?
-Brad


Survey of NUL in documented formats:
------------------------------------------------------------------------
* Documentation/diff-format.txt: The -z mode for --numstat prints
  NUL-terminated lines but there is exactly one path at the end of
  each entry and the earlier fields are separated by TAB because
  they are structured.

* Documentation/diff-options.txt: The -z mode for diff-tree output
  prints structured SP/TAB-separated fields in a NUL-terminated
  field followed by either one or two NUL-terminated paths.  This
  is variable width but the first field tells us how wide.

* Documentation/git-apply.txt: The -z mode forwards to --numstat
  diff options.

* Documentation/git-check-attr.txt: The -z mode for stdin reads
  NUL-terminated paths.

* Documentation/git-check-ignore.txt: The -z mode for stdin reads
  NUL-terminated paths.  The -z mode for output prints a fixed-width
  table with every group of four NUL-terminated fields forming a row.

* Documentation/git-checkout-index.txt: The -z mode reads
  NUL-terminated paths.

* Documentation/git-commit.txt: The -z mode forwards to git-status.

* Documentation/git-grep.txt: The -z mode separates file names from
  the matched line by a NUL.  Therefore NUL divides LF-terminated
  lines into two pieces.

* Documentation/git-ls-files.txt: The -z mode prints NUL-terminated
  lines but there is exactly one path at the end of each entry and the
  earlier fields are separated by SP and TAB because they are
  structured.

* Documentation/git-ls-tree.txt: The -z mode prints NUL-terminated
  lines but there is exactly one path at the end of each entry and the
  earlier fields are separated by SP and TAB because they are
  structured.

* Documentation/git-mktree.txt: The -z mode reads NUL-terminated lines
  as output by ls-tree -z.

* Documentation/git-status.txt: The -z mode of --porcelain separates
  a variable number of entries by NUL.  The beginning of each entry
  allows one to know the number of NUL-terminated fields to expect
  (A = 1 total NUL, R = 2 total NULs, etc.).

* Documentation/git-update-index.txt: The -z mode of --stdin separates
  paths by NUL.  The -z mode of --index-info separates entries by NUL
  but there is exactly one path at the end of each entry and the earlier
  fields are separated by SP and TAB because they are structured.

* Documentation/rev-list-options.txt: The --header option prints
  commits separated by NUL but they are never empty.
------------------------------------------------------------------------
