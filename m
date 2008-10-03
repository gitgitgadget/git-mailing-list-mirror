From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Fri, 3 Oct 2008 12:31:38 +0200
Message-ID: <200810031231.40146.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <200810030248.57144.jnareb@gmail.com> <cb7bb73a0810022304r11d2ad87q7691213ff67f7e4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 13:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlirV-0004h3-9f
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 13:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYJCL3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 07:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYJCL3I
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 07:29:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:51313 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbYJCL3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 07:29:07 -0400
Received: by nf-out-0910.google.com with SMTP id d3so600731nfc.21
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rI0qh7GFSk1zsP3k5K+jbDCMnMPME+C5PyMuphZJZH0=;
        b=M1c9B5KxB8OY3kgdmtwrV29CdFwTu7eebTOFBnJq9M4FOKpZc7fQkDwCt/q0vIctyj
         2yd/8I/Gt3S7/BUD5yVetSYCkn8BrM7+DX0qzaIBA+xe578BCftbtO6r98Jxm0dtgG3h
         /Ew8sWKFVWxiRaC28uA7ECg4kIGyvxgbbeicg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tz0H85Kmae7CLxaoIkboUZlcRgq/d50jxluaRewxkVXJ3/ie4M4nsujm2NDAb2upVA
         MpJxr9u4IAKjaASZQ1VfOVX09Tf4CueW6DKZ5/zytc881i0nZ96Pl05pIOn3FhH/kmWs
         N9UYQPdesIbq+SgX7QWvcayhttHy5sMIgjeYI=
Received: by 10.210.68.17 with SMTP id q17mr1106008eba.190.1223033345033;
        Fri, 03 Oct 2008 04:29:05 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 5sm4069380eyf.8.2008.10.03.04.29.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 04:29:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810022304r11d2ad87q7691213ff67f7e4c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97413>

On Fri, 3 Oct 2008, Giuseppe Bilotta wrote:
> On Fri, Oct 3, 2008 at 2:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

>>> But implementing the path_info parsing first makes the input param
>>> refactoring SO much nicer that I would rather put a comment here
>>> saying "this code sucks: we should rather collect all input
>>> parameters" and then clean it up on the subsequent patch.
>>
>> Why not cleanup first?
> 
> Because cleaning it up depends on the refactoring, and the refactoring
> is much cleaner when path_info already handles $action too.

Hmmm... it looks like after refactoring you don't have to change href()
at all when adding $action to parameters gitweb can get from path_info;
all that having refactoring (cleanup) upfront changes in/for this patch
is a bit different saving action (also in %input_params) and lack of
this ugly and I think subtly wrong added code for href(...,-replay=>1).
 
>> When implementing href(..., -replay=>1) I have forgot that some of
>> gitweb parameters are implicitly passed ($project, because it is needed
>> in most gitweb links), and some can be passed via path_info ($hash
>> and/or $hash_base, $file_name). Your code adds $action to the mix, but
>> it doesn't change the fact that 1.) even before your code -replay case
>> was incorrect for some path_info links (handcrafted, as gitweb generates
>> only $project via path_info); 2.) code you have added is a bit ugly.
>>
>> Besides using variables change a little meaning of -replay, namely
>> in your code gitweb always sets action, even for non-path_name links
>> when we started from "default action" (i.e. without action set) links.
>> I guess this is mainly theoretical issue, as I don't think that default
>> views use many -replay links.
> 
> Ah the issue of the default action is something I hadn't taken into
> consideration, actually. Now the question is, should replay keep
> default -> default, or should it go with default -> last incantation?

I think we should use default -> default.

Besides I think there can also be an issue ("can" because I am not sure
if in practice it is a problem) the fact that gitweb sometimes expand
parameters to sha-1, for example setting $head to git_get_head_hash()
if it is not set (default param value), and not to 'HEAD'. This perhaps
should be changed, but to be on safer side better not to use 'action
variables' because some code treats them as temporary variables.

>> P.S. with the idea of pushing parameters obtained not from CGI query
>> string to $cgi->param() via "$cgi->param($name, $value);" or in named
>> params form "$cgi->(-name=>$name, -value=>$value);" you would not need
>> to change (a bit hacky, admittedly) href(...,-replay=>1) code.
> 
> Yes, but it would muddy the waters about 'where did this parameter
> come from' in case we ever need to know that.

True. Like for example implementing -faithful_replay where if parameter
was passed through path_info it is replayed through path_info, and if
it was passed through query string it is replayed as CGI query param.

After thinking a bit about that I think that %input_params idea is
superior to both $cgi->params(-name=>..., -value=>...) and to have
either no strict refs $$name or name to action variable ref hash.
See also my comment for the refactoring patch.

-- 
Jakub Narebski
Poland
