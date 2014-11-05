From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5] lockfile.c: store absolute path
Date: Wed, 05 Nov 2014 15:19:28 +0100
Message-ID: <545A31F0.5080306@alum.mit.edu>
References: <1414909477-20030-1-git-send-email-mhagger@alum.mit.edu> <20141105022315.GA28292@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Yue Lin Ho <yuelinho777@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 15:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm1R7-0003zu-Lr
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 15:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbaKEOTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 09:19:44 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:63525 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751500AbaKEOTn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2014 09:19:43 -0500
X-AuditID: 1207440f-f79ea6d000004f72-77-545a31f32397
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id AE.87.20338.3F13A545; Wed,  5 Nov 2014 09:19:31 -0500 (EST)
Received: from [192.168.69.130] (p5DDB064F.dip0.t-ipconnect.de [93.219.6.79])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sA5EJSFH031618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 5 Nov 2014 09:19:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.1.2
In-Reply-To: <20141105022315.GA28292@odin.ulthar.us>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqPvZMCrEYHuLrUXXlW4mi4beK8wW
	T+beZbbonvKW0WL3tAVsFm07jzA5sHnsnHWX3ePhqy52j4uXlD0eTzzB6vF5k1wAaxS3TVJi
	SVlwZnqevl0Cd8aq1fNZC15zVcw7+YSxgfEyRxcjB4eEgInE3olBXYycQKaYxIV769m6GLk4
	hAQuM0qsWL+UHcI5wyRxbvcDZpAqXgFtif3TFoLZLAKqEgfv72EEsdkEdCUW9TQzgdiiAkES
	H07uZIeoF5Q4OfMJC8ggEYGFTBIbJvaxgiSEBcwljny4zQZiCwnkSMxrfsECchEn0EWbH9WD
	mMwC6hLr5wmBVDALyEtsfzuHeQIj/ywkU2chVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJi
	Xl5qka6JXm5miV5qSukmRkhA8+9g7Fovc4hRgINRiYfXIDcyRIg1say4MvcQoyQHk5Ior5dO
	VIgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4mbaAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpi
	SWp2ampBahFMVoaDQ0mC94ABUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KBrj
	i4HxCJLiAdp7GqSdt7ggMRcoCtF6ilFRSpz3nz5QQgAkkVGaBzcWlqZeMYoDfSnMuw2knQeY
	4uC6XwENZgIabNETATK4JBEhJdXAuHmp+dKDW4/237734rPbhUfbCxP7Tq/8qnFZ50W+9InV
	Ar+Fy+9Mc8z6+Dj4q1vRav8XHJGnHquqTjsZdkB/8V6PduadUwsEf6/JNzlx6cL6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05/2014 03:23 AM, Scott Schmit wrote:
> On Sun, Nov 02, 2014 at 07:24:37AM +0100, Michael Haggerty wrote:
>> Locked paths can be saved in a linked list so that if something wrong
>> happens, *.lock are removed. For relative paths, this works fine if we
>> keep cwd the same, which is true 99% of time except:
>>
>> - update-index and read-tree hold the lock on $GIT_DIR/index really
>>   early, then later on may call setup_work_tree() to move cwd.
>>
>> - Suppose a lock is being held (e.g. by "git add") then somewhere
>>   down the line, somebody calls real_path (e.g. "link_alt_odb_entry"),
>>   which temporarily moves cwd away and back.
>>
>> During that time when cwd is moved (either permanently or temporarily)
>> and we decide to die(), attempts to remove relative *.lock will fail,
>> and the next operation will complain that some files are still locked.
>>
>> Avoid this case by turning relative paths to absolute before storing
>> the path in "filename" field.
> 
> This might be a little pathological, but it seems like this scheme would
> run into trouble if the entire repo is moved while the lock is held.

Correct. You shouldn't move a repository while Git operations are
running in it. That would break for many reasons, not just because of
this change to lockfile handling.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
