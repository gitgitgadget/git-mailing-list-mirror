From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-filter-branch: add --egrep-filter option
Date: Tue, 19 Apr 2011 03:01:43 -0500
Message-ID: <20110419080143.GA17915@elie>
References: <4DA8CBB0.6080103@rivulet.ca>
 <201104161016.51690.j6t@kdbg.org>
 <4DAA464E.7010804@rivulet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
X-From: git-owner@vger.kernel.org Tue Apr 19 10:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC5sg-0000DH-BO
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 10:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab1DSIBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 04:01:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63416 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1DSIBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 04:01:48 -0400
Received: by iyb14 with SMTP id 14so4560346iyb.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=n305biLMgkDPzjK1+HO4kAsmV+HG4316vdvZY7itm2g=;
        b=JzYF00SV6gcvHiSohZVJEWQkQQBelNYTbUri/gDxvFLQMfb7mZZZ821jhvQDBPtO+G
         +Zkca5/oTqZ8Mc/J17FEbfcFH7+C66hVhoEiAJZ7Zh2nyePbWW8yLZ8AUHFhaxhAznhd
         TiHFy/1PHuOcXeN5QaYP3O0HUTzvW00Q2DPvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Llh/sdaeBgcLHdiOj+WPIy9JcPWC72Q2vWhAza29jubZHg196YkxIRuw813a5P/T52
         jCQLLhntdy5fqfWjZv+3xhvn7gDlzjy5NIgBD/dKHGYkaZNeOThnT1EF7UAJ11/fFQ6a
         SVIYCLp3EHhz7cI9CEWgrX/OAWk+kalUTVv1A=
Received: by 10.43.54.9 with SMTP id vs9mr7759491icb.5.1303200108267;
        Tue, 19 Apr 2011 01:01:48 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id d9sm3181735ibb.53.2011.04.19.01.01.46
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 01:01:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DAA464E.7010804@rivulet.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171780>

Hi,

Michael O'Cleirigh wrote:

> After considering your comment I have to agree with you that it is a
> special case of index-filter and probably not useful/general for
> enough other cases to justify adding in a new command line option.

Now, why do you give up so easily? ;-)

Surely what your patch is hinting at is the possibility of an
--ls-tree-filter (for lack of a better name) that works with trees
without the overhead of unpacking them.  On the other hand I do agree
with Hannes that allowing only "egrep" is a bit overspecialized.

In practice I would have used something like

	--commit-filter='
		tree=$1 &&
		new_tree=$(
			git ls-tree $commit |
			egrep "$filter_egrep" |
			git mktree
		) &&
		shift &&
		git_commit_non_empty_tree "$new_tree" "$@"
	'

so another (simpler?) solution might be an entry for the EXAMPLES
section of the manual along these lines.

Ciao,
Jonathan
