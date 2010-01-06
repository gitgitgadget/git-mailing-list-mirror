From: Andrew Myrick <amyrick@apple.com>
Subject: Re: [PATCH 1/2] git-svn: ignore changeless commits when checking	for a cherry-pick
Date: Wed, 6 Jan 2010 14:52:03 -0800
Message-ID: <E10FB265-0C47-44C7-9347-687A9F447603@apple.com>
References: <1262808529-1575-1-git-send-email-amyrick@apple.com> <20100106214338.GA5115@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v1131)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sam@vilain.net
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 23:52:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSejf-00012H-19
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 23:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab0AFWwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 17:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373Ab0AFWwH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 17:52:07 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:55248 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759Ab0AFWwG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 17:52:06 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out3.apple.com (Postfix) with ESMTP id DCED77F39991;
	Wed,  6 Jan 2010 14:52:03 -0800 (PST)
X-AuditID: 11807130-b7b0aae00000102c-2b-4b4514134b87
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay11.apple.com (Apple SCV relay) with SMTP id F3.9E.04140.314154B4; Wed,  6 Jan 2010 14:52:03 -0800 (PST)
In-Reply-To: <20100106214338.GA5115@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1131)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136308>


On Jan 6, 2010, at 1:43 PM, Eric Wong wrote:

> Andrew Myrick <amyrick@apple.com> wrote:
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 650c9e5..8c7c034 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -3052,12 +3052,36 @@ sub check_cherry_pick {
>> 	for my $range ( @ranges ) {
>> 		delete @commits{_rev_list($range)};
>> 	}
>> +        for my $commit (keys %commits) {
> 
> Hi Andrew,
> 
> I'll again defer to Sam for Acks on these.  Test cases would be nice to
> have, too.

I'll see what I can do.  The test cases are conceptually simple (the svn dump I sent out the other day will exercise one of these patches), but it will take me some time to learn git's testing infrastructure, and I have impending deadlines on other work, so I can't promise anything immediate.

> 
> A few notes:
> 
> The prevailing standard for indentation in git is with hard tabs and
> that's certainly the case with the rest of git-svn.perl.
> 
>> +sub has_no_changes {
>> +        my $commit = shift;
>> +
>> +        my @revs = split / /, command_oneline(
>> +                qw(rev-list --parents -1 -m), $commit);
>> +
>> +        # Commits with no parents, e.g. the start of a partial branch,
>> +        # have changes by definition.
>> +        return 1 if (@revs < 2);
>> +    
> 
> I've become very picky about trailing whitespace (from Junio :), too.
> "git diff --check" is helpful for this, especially in the pre-commit
> hook.

My apologies for not noticing this.  I'll regenerate patches that conform to the style guidelines.  Thanks for pointing out `git diff --check`; it's quite helpful.

-Andrew