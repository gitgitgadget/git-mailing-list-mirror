From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 1/2] [RFC] Detect attempts at calling git init specifying a
 remote repository.
Date: Tue, 16 Nov 2010 21:10:03 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1011162107580.13543@perkele.intern.softwolves.pp.se>
References: <cover.1289561504.git.peter@softwolves.pp.se>
 <3f7d07a2b3a02c1d3f864d2a17f3b8808890a4d1.1289561504.git.peter@softwolves.pp.se>
 <7vfwv1i22u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 21:10:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIRrD-0002Ij-If
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 21:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab0KPUKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 15:10:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51956 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538Ab0KPUKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 15:10:14 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBZ006DZUP0Z080@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Nov 2010 21:10:12 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 94C8C1EA5583_CE2E524B	for <git@vger.kernel.org>; Tue,
 16 Nov 2010 20:10:12 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7F9D51EA2FEA_CE2E524F	for <git@vger.kernel.org>; Tue,
 16 Nov 2010 20:10:12 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBZ00DVHUP0WF00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Nov 2010 21:10:12 +0100 (MET)
Received: by perkele (Postfix, from userid 501)	id 621EC2FC06; Tue,
 16 Nov 2010 21:10:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 60A5B2FC04; Tue, 16 Nov 2010 21:10:03 +0100 (CET)
In-reply-to: <7vfwv1i22u.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161584>

Junio C Hamano:

>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -435,7 +435,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>>  		int mkdir_tried = 0;
>>  	retry:
>>  		if (chdir(argv[0]) < 0) {
>> -			if (!mkdir_tried) {
>> +			if (is_url(argv[0]) || strchr(argv[0], '@') != NULL || (strchr(argv[0], ':') != NULL && !has_dos_drive_prefix(argv[0]))) {
>> +				/*
>> +				 * We were passed a remote repository specification.
> Or a directory with ':' in its pathname, no?

Indeed. Don't do that, then :-)

Seriously, though, I tried finding an API that checked if the pathspec is 
local or remote, but I was unable to. Is there one I should use instead?

-- 
\\// Peter - http://www.softwolves.pp.se/
