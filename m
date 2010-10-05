From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Remote helper: accept ':<value> <name>' as a
 response to 'list'
Date: Mon, 4 Oct 2010 21:00:35 -0500
Message-ID: <20101005020035.GA10818@burratino>
References: <4CA86A12.6080905@dbservice.com>
 <1286108511-55876-1-git-send-email-tom@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 04:04:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2wt7-00064W-Ut
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 04:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab0JECDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 22:03:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35626 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0JECDy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 22:03:54 -0400
Received: by ywg8 with SMTP id 8so51274ywg.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 19:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c4/6OYPNQzLk+t/LK2b83bIjI/RttekBF2wXgHaxuB0=;
        b=M9i7OqNjq9H1hXwJqBCUkV4+PsLj9zlAOs0TvS0xASvP7UUHHL1CQftyKmZndHAWzm
         MZ5FY1gFzvhml+UyHBxPqrtOW+Yc2ggtoMWj8YMojQNVvGmwiPumy27gPQtwZnHlCO1C
         FWj4SpLnwNlQvrFfNqhYigD3jLQvvUNlSmywY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Yn8iKZJZQTGbtzHlE38RgrRVaYbr97Vu481JJtZFTGoLKoBPJ2UvLw6OMCh2ICTsu1
         latIZ+6tj9gh7xpdUx9nPUYBFNCCSy4ZGvZn5ARjmgvLpr1tgc0s6kO2QW8eegHAhHjE
         W8m5kk03Oa/BoAdou1xLSIRc31Qq8Xup2x6SE=
Received: by 10.220.201.73 with SMTP id ez9mr15600vcb.90.1286244233853;
        Mon, 04 Oct 2010 19:03:53 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m4sm4510432vbp.16.2010.10.04.19.03.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 19:03:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286108511-55876-1-git-send-email-tom@dbservice.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158157>

Hi,

Tomas Carnecky wrote:

>                                                          The ref is first stored
> as 'impure', meaning that it doesn't have any representation within git. Only
> after the remote helper fetches that version into git, it can tell us which
> git object (SHA1) that revision maps to.

Hmm.

The existing ls-remote output looks something like

	<object id>	HEAD
	<object id>	<refname>
	<object id>	<refname>
	...
	<object id>	<tag refname>
	<object id>	<tag refname>^{}
	...

In particular, each line has a 40-character object id, a tab character,
and then something like a refname.

If we want to extend that, wouldn't we need to do something like

	0000...0000	<refname>
	0000...0000	<refname> is r11

to avoid breaking people's scripts?  For example, I wouldn't be surprised
if scripts are relying on the following two properties:

 - each object id is 40 characters (e.g., the old fetch--tool
   in contrib/examples relies on this)
 - each object id contains no whitespace

simply because they are convenient to script with.
