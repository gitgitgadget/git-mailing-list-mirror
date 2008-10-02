From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Fri, 3 Oct 2008 00:41:52 +0200
Message-ID: <200810030041.54563.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <cb7bb73a0810021405j68b0a164i9469e64afc543ebf@mail.gmail.com> <20081002220439.GX10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 03 00:43:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlWtC-0000fa-DW
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 00:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbYJBWmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 18:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYJBWmF
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 18:42:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60148 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbYJBWmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 18:42:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so533878nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5Mz8r6SdXQ7vKOXIyffVXq9lLEk0GATba/Ok0YKWaiQ=;
        b=sDA9fekD9ndpBnnnKCjQj0Kn7HZNbo2SQO3Awo4LKu2slMxPYeqneBRYsypze3WzTQ
         yX0kh68hw2p3orKMbikRTObk8jhCERKU3Dc0bdlBKxM+XVJhd8sp+w9WHldwHc9UpYp9
         e+jzwOPyDlv1O4yAiZtUPkZA968ymEFk0j1hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jIG1zscrzR0sUMIJgkfybg9ato9+SlMORsIJGP+/oPB1q0y+La6IaNs9f87VSBhiXb
         A3qSxhM09oZPSltOFVCxTaUenU/HvrLwp7P2zFMGsHXxWmFfcv3MoG9KYcixwiagB8zr
         is6UeKMxPoIIL5AqSWWkk8y3RY4N+RgtpT7NE=
Received: by 10.210.123.2 with SMTP id v2mr243607ebc.147.1222987321902;
        Thu, 02 Oct 2008 15:42:01 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 20sm3199205eyc.9.2008.10.02.15.41.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 15:42:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20081002220439.GX10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97379>

Petr Baudis wrote:
> On Thu, Oct 02, 2008 at 11:05:18PM +0200, Giuseppe Bilotta wrote:
> >
> > In preparing the new patchset, I've put a big comment block explaining
> > why we need to set both $hash and $hash_base in this code-path:
> > 
> > # we got "project.git/[action/]branch". in this case
> > # we set both $hash and $hash_base because different actions
> > # need one or the other to be set to behave correctly.
> > #
> > # For example, if $hash_base is not set then the blob and

'blob' without $file_name doesn't have sense, but 'tree' does.
Probably should be s/blob/tree/ above.

> > # history links on the page project.git/tree/somebranch will
> > # assume a $hash_base of HEAD instead of the correct
> > # somebranch.
> > # Conversely, not setting $hash will make URLs such as
> > # project.git/shortlog/somebranch display the wrong page.
> > #
> > # Since it also turns out that the unused one is properly
> > # overwritten as needed, setting both is quite safe.
> 
>   Ok, but is this related to the pathinfo changes? Or is this fixing a
> separate bug? (Not that I would want to bother you with splitting this,
> but you should at least mention it in the commit message... and it's
> fairly isolated anyway.)

Yes, it related to path_info changes. With current code the only way
to get to no $file_name branch of evaluate_path_info() code was to have
URL which looks like project/branch, for which 'shortlog' action was
chosen (if not specified by CGI query parameters), and for 'shortlog'
action the correct way was to use $hash. Now there can be
project/tree/branch to show top directory of given branch, and this
as described required $hash_base set.

-- 
Jakub Narebski
Poland
