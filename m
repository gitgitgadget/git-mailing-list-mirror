From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within
 transactions
Date: Tue, 12 May 2015 10:32:08 +0200
Message-ID: <5551BA88.3090900@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>	<1431357920-25090-2-git-send-email-mhagger@alum.mit.edu> <xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 10:32:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys5c1-0004N0-1W
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 10:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbbELIcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 04:32:21 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:65456 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932087AbbELIcT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2015 04:32:19 -0400
X-AuditID: 1207440c-f79376d00000680a-22-5551ba8b9751
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C3.3D.26634.B8AB1555; Tue, 12 May 2015 04:32:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C91.dip0.t-ipconnect.de [93.219.28.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4C8W9gU019060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 12 May 2015 04:32:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqNuzKzDUoLeH0aLrSjeTRUPvFWaL
	Hy09zBabN7ezWJx508jowOqxYFOpx7PePYweFy8peyx+4OXxeZNcAGsUt01SYklZcGZ6nr5d
	AnfGxTnzmAqucVS8PtbE1sD4gq2LkZNDQsBEovP5UhYIW0ziwr31QHEuDiGBy4wSf04+gnLO
	M0ksm7iQHaSKV0Bb4sqJLkYQm0VAVeLXoSYwm01AV2JRTzMTiC0qECTRem0qI0S9oMTJmU/A
	NogIqElMbDvEAjKUWWAio8TetTvAGoQFIiVuz/wP1iAksIZRYsEDDRCbU8BaYvPB3WBxZgE9
	iR3Xf7FC2PISzVtnM09gFJiFZMcsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRr
	qJebWaKXmlK6iRES4jw7GL+tkznEKMDBqMTD23HJP1SINbGsuDL3EKMkB5OSKG/VisBQIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK8taVAOd6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTU
	gtQimKwMB4eSBO+1HUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aBojS8GxitI
	igdo7z6Qdt7igsRcoChE6ylGRSlxXrmdQAkBkERGaR7cWFjiesUoDvSlMK8TSBUPMOnBdb8C
	GswENNgxLgBkcEkiQkqqgXG25/oVPO/XJwRW1Yn1VKjUTXtnW1iyTvZHhnT3/tRLu2xMOIoj
	dr+YnKLPVO8daOdjFTZvv4bXVcuNxXcFpL/v/X3BMGDyrZ6LM2c/+bAkfJrWTHcL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268846>

On 05/11/2015 09:37 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +test_update_rejected () {
>> +	prefix="$1" &&
>> +	before="$2" &&
>> +	pack="$3" &&
>> +	create="$4" &&
>> +	error="$5" &&
>> +	printf "create $prefix/%s $C\n" $before |
>> +	git update-ref --stdin &&
>> +	git for-each-ref $prefix >unchanged &&
>> +	if $pack
>> +	then
>> +		git pack-refs --all
>> +	fi &&
>> +	printf "create $prefix/%s $C\n" $create >input &&
>> +	test_must_fail git update-ref --stdin <input 2>output.err &&
>> +	grep -F "$error" output.err &&
> 
> I am not 100% confident that "grep -F" is the right thing to use
> here.  I checked all the error message these tests are expecting and
> none seems to go through _(), but is it fundamental that these
> errors should not be translated?

Aren't tests run in the "C" locale so that tests don't have to worry
about i18n?

Regarding "grep -F", what would be a better alternative, given that I
want to test that the conflict is being reported correctly?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
